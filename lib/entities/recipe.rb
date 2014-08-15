module Bartender
  class Recipe
    attr_reader :name, :ingredients, :directions, :imageurl
    def initialize(name, ingredients, directions, imageurl)
      @name = name
      @directions = directions
      @imageurl = imageurl
      @ingredients = ingredients
    end
  end

end