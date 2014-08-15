require 'pg'
require_relative '../entities/parser.rb' 
module Bartender
  class DBI
 
    # this initialize method is only ever run once.
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'bartender')
      build_tables
    end
    
    # these methods create the tables in your db if they
    # dont already exist
    def build_tables
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS ingredients(
          id serial NOT NULL PRIMARY KEY,
          name varchar(30) NOT NULL UNIQUE,
          type text
        )])
  
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS recipes(
          id serial NOT NULL PRIMARY KEY,
          name varchar(30) NOT NULL UNIQUE,
          directions text,
          imageurl varchar(150)
        )])
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS recipes_ingredients(
          id serial NOT NULL PRIMARY KEY,
          recipe_id integer references recipes(id),
          ingredient_id integer references ingredients(id),
          amount integer, 
          unit varchar(30)
        )])
  
    end

    def get_recipes_by_id(recipe_id)
      @db.exec_params(%q[
        SELECT * FROM recipes
        WHERE id = $1;], [recipe_id])
    end

    def get_ingredient_name_by_id(ingredient_id)
      @db.exec_params(%q[
        SELECT name FROM ingredients
        WHERE id = $1;], [ingredient_id]).first
    end

    def get_ingredient_id_by_name(name)
      @db.exec_params(%q[
        SELECT id FROM ingredients
        WHERE id = $1;], [name]).first
    end

    def get_all_ingredients
      @db.exec_params(%q[SELECT * FROM ingredients;])
    end

    def get_search_results(array_of_ingredient_ids)
      search_for_string = "("
      array_of_ingredient_ids.each do |i|
        search_for_string << "#{}"
      end
      #TODO SQL RETURN ALL OF THE RECIPES THAT HAS ONE OF THOSE INGREDIENTS
    end

    def get_search_results(array_of_ingredient_ids)
      db_object = []
      array_of_ingredient_ids.each do |i|
        db_object << @db.exec_params(%q[SELECT * FROM recipes
                                        WHERE id = $1;], i)
      end
      db_object #Returns an array of db result objects like this [[{keys and values},{},{}]]
    end

    def build_recipe(data)
      recipe = Bartender::Recipe.new(data[name], data[ingredients], data[direction], data[imageurl]);
      recipe
    end

    def persist_recipe(recipe)
      result = @db.exec_params(%q[
        INSERT INTO recipes (name, directions, imageurl)
        VALUES ($1, $2, $3, $4);
        ], [recipe.name, recipe.directions, recipe.imageurl])
      recipe.ingredients.each do |i|
        @db.exec_params(%q[
          INSERT INTO recipes_ingredients(recipe_id, ingredient_id, amount, unit)
          VALUES ($1, $2, $3, $4);
          ], [result.first[:id], i.id, i.amount, i.unit])i
      end
    end

  end

  # singleton creation
  def self.dbi
    @__db_instance ||= DBI.new
  end
end