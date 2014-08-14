# required gem includes
require 'sinatra'
require "sinatra/json"
require 'rack-flash'
require_relative 'lib/bartender_app.rb'


set :bind, '0.0.0.0' # Vagrant fix
set :port, '4567'

get '/' do
  erb :index
end

get '/recipe/:id' do
  if params[:id].to_i != 0
    #@id = params['id']
    #@recipe = Bartender.dbi.get_recipe(@id)
    erb :recipe
  else
    erb :add_recipe
  end
end

get '/search/*id' do
  @result = Bartender.dbi.get_search_results(params['id'])
end

get '/brianteststuff' do
  erb :brianteststuff
end

post '/brianteststuff' do
  recipe = Bartender::Recipe.new("Vodka Cranberry",[[name:"vodka",amount:"2",unit:"oz"],[name:"cranberry juice",amount:"2",unit:"oz"]] ,"Mix Vodka and Cranberry straight or over ice.","http://leesliquorlv.com/site/wp-content/uploads/2012/09/Vodka-Cran.jpg")
  Bartender.dbi.persist_recipe(recipe)
  erb :brianteststuff
end
