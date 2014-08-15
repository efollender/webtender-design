require 'open-uri'
require 'nokogiri'

module Bartender
  class Recipe
    attr_reader :name, :ingredients
    def initialize(name, ingredients, directions=nil, imageurl=nil)
      @name = name
      @directions = directions
      @imageurl = imageurl

      @ingredients = []
    end
  end

end


def getdrinks(num)
  root = "http://www.webtender.com"
  if num < 800
    dbUrl = 'http://www.webtender.com/db/browse?level=2&dir=types&char=2&start='+num.to_s
    dbdoc = Nokogiri::HTML(open(dbUrl))
    drinklinks = dbdoc.css('a').map { |link| root + link['href'] }
    drinklinks.each do |link|
      if link.include?("/db/")
        doc = Nokogiri::HTML(open(link))
        drinkTitle = doc.xpath("//h1").inner_text()
        ings = doc.xpath("//li").to_a()
        ingrs = []
        ings.each do|x|
          if x.inner_html().include?("ingr")
            # x.inner_text().split(" ")
            x.inner_html().include?("ingr")
          end
        end
        puts Bartender::Recipe.new(drinkTitle, ingrs).name
      end
    end
    getdrinks(num+151)
  else
    puts "done"
  end
end
getdrinks(1)
