# required gem includes
require 'sinatra'
require "sinatra/json"
require 'rack-flash'
require_relative 'lib/bartender_app.rb'


set :bind, '0.0.0.0' # Vagrant fix
set :port, '4567'

get '/' do
  @home = 'js/home.js'
  erb :index
end

get '/recipe/:id' do
  if params[:id].to_i != 0
    #@id = params['id']
    #@recipe = Bartender.dbi.get_recipe(@id)
    erb :recipe
  end
end

get '/search/*id' do
  #@result = Bartender.dbi.get_search_results(params['id'])
end

get '/add_recipe' do
  #@ingredients = Bartender.dbi.get_all_ingredients
  erb :add_recipe
end

post '/add_recipe' do
  count = (params.length - 3)/3
  for i in 1..count+1
    puts params['amount-'+i.to_s]

  end
  redirect to '/'
end

get '/brianteststuff' do
  erb :brianteststuff
end

post '/brianteststuff' do
  recipe = Bartender::Recipe.new("Vodka Cranberry",[[name:"vodka",amount:"2",unit:"oz"],[name:"cranberry juice",amount:"2",unit:"oz"]] ,"Mix Vodka and Cranberry straight or over ice.","http://leesliquorlv.com/site/wp-content/uploads/2012/09/Vodka-Cran.jpg")
  Bartender.dbi.persist_recipe(recipe)
  erb :brianteststuff
end
