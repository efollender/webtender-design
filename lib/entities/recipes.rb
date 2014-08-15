module Bartender
  class Recipe
    attr_reader :name, :ingredients, :directions, :imageurl
    def initialize(name, ingredients, directions, imageurl)
      @name = name
      @directions = directions
      @imageurl = imageurl

      @ingredients = []
      objectify_ingredients(ingredients)
    end

    def objectify_ingredients(ingredients) #convert ingredients to be better used by the object
      ingredients.each do |i|
        new_ing = @ingredients.push({name: Bartender.dbi.get_ingredient_name_by_id(i[0]), amount: i[1], unit: i[2]})
      end
    end

    def format_for_db(ingredients) #convert ingredients to be better used by the database
      #TODO: Should return a 3 by n array of ingredients like ingredients[3][n] if that makes sense
      ingredients_db = []
      ingredients.each_with_index do |ingredient, index|
        ingredients_db.push(Array.new(3))
        ingredients_db[index][0] = Bartender.dbi.get_ingredient_id_by_name(ingredient[:name])
        ingredients_db[index][1] = ingredient[:amount]
        ingredients_db[index][2] = ingredient[:unit]
      end
      ingredients_db
    end
  end

end