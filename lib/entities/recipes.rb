module Bartender
  class Recipe

    def initialize(name, ingredients, directions, imageurl)
      @name = name
      @directions = directions
      @imageurl = imageurl

      @ingredients = []
      objectify_ingredients(ingredients)
    end

    def objectify_ingredients(ingredients) #convert ingredients to be better used by the object
      ingredients.each do |i|
        new_ing = @ingredients.push({name: Bartender.dbi.get_ingredient_name_by_id(i[0].to_i), amount: i[1], unit: i[2]})
      end
    end

    def format_for_db(ingredients) #convert ingredients to be better used by the database
      #TODO: Should return a 3 by n array of ingredients like ingredients[3][n] if that makes sense
    end
  end

end