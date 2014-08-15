module Bartender
  class Ingredient
    attr_reader :id, :name, :type, :amount, :unit
    def initialize(id, name, amount, unit, type="alcohol")
      @id = id
      @name = name
      @type = type
      @amount = amount
      @unit = unit
    end
  end
end