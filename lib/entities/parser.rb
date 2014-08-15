require 'open-uri'
require 'nokogiri'

module Bartender
  module Parser
    def parse_ingredients
      ingredients = File.readlines("../ingredients.txt").map &:split
    
    end
  end
end

