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


def getDrinks(num=1,limit=1000)
  root = "http://www.webtender.com"
  if num < limit
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
            ing_arr = x.inner_text().split(" ")
            if ing_arr[1]
              if ing_arr[1][0].to_i > 0
                ingrs << ing_arr[3..(ing_arr.length-1)].join(" ")
              else
                ingrs << ing_arr[2..(ing_arr.length-1)].join(" ")
              end
            end
          end
        end
        method = doc.xpath("//td[@width='90%']/descendant::p").first.inner_text()
        File.open('public/recipes.txt', 'a') { |file| file.puts({name: drinkTitle, ingredients: ingrs, directions: method }) } 
      end
    end
    getDrinks(num+151)
  else
    puts "done"
  end
end

def getIngredients(num=0,start=1,limit=1)
  root = "http://www.webtender.com"
  ingredients = []
  if num == 0
    limit = 151
  end
  if (start < limit+1) && (num < 6)
    dbUrl = 'http://www.webtender.com/db/browse?level=2&dir=ingralc&char=' + num.to_s + '&start=' + start.to_s
    dbdoc = Nokogiri::HTML(open(dbUrl))
    drinklinks = dbdoc.css('a').map { |link| root + link['href'] }
    drinklinks.each do |link|
      if link.include?("/db/")
         doc = Nokogiri::HTML(open(link))
         drinkTitle = doc.xpath("//h1").inner_text()
         type = doc.xpath("//table[@width=220]/descendant::a").to_a().first.inner_text()
         File.open('public/ingredients.txt', 'a') { |file| file.puts({name: drinkTitle, type: type}) }
      end
    end
    if num == 0
      getIngredients(num,start+150)
    end
    getIngredients(num+1)
  else
    puts "done"
  end
end
getIngredients()
count = 0
File.open('public/ingredients.txt') {|f| count = f.read.count("\n")}
puts count
