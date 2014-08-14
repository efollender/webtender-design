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
