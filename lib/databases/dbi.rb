require 'pg'
 
module Bartender
  class DBI
 
    # this initialize method is only ever run once. make sure you
    # update your `dbname`. here it is petbreeder.
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
        )])
  
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS recipes(
          id serial NOT NULL PRIMARY KEY,
          drink_name varchar(30) NOT NULL UNIQUE,
          ingredient text[][], 
          directions text
        )])
        #ingredient with amount is a 3 by n two dimensional array 
        #[0][n] corresponds to the ingredient ID of an ingredient
        #[1][n] corresponds to the numerical amount on the ingredient (It's text, but separated for a to_int)
        #[2][n] corresponds to the units associated with the ingredient amount.
  
    end

    def get_recipes_by_id(recipe_id)
      @db.exec_params(%q[
        SELECT * FROM recipes
        WHERE id = $1;], [recipe_id])
    end

    def get_ingredient_name_by_id(ingredient_id)
      @db.exec_params(%q[
        SELECT name FROM ingredients
        WHERE id = $1;], [ingredient_id])
    end

    def build_recipe(name, ingredients, directions, imageurl)
      #TODO
    end

    def persist_recipe(recipe)
      @db.exec_params(%q[
        INSERT INTO recipes (name, ingredients, directions, imageurl)
        VALUES ($1, $2, $3, $4);
        ], [recipe.name, recipe.format_for_db(ingredients), recipe.directions, recipe.imageurl])
    end

    
    # Breed Methods

    def create_breed(breed, price)
      @db.exec_params(%q[
        INSERT INTO breeds (breed, price)
        VALUES ($1, $2);
      ], [breed, price])
    end

    def self.set_status(id, status)
      @db.exec_params(%q[
        UPDATE purchase_orders SET status = $2
        WHERE id = $1;
        ], id, status)
    end
  end

  # singleton creation
  def self.dbi
    @__db_instance ||= DBI.new
  end
end