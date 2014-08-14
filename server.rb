# required gem includes
require 'sinatra'
require "sinatra/json"
require 'rack-flash'


set :bind, '0.0.0.0' # Vagrant fix
set :port, '4567'

get '/' do
  erb :index
end

get '/recipe/:id' do
  #@id = params['id']
  #@recipe = Bartender.dbi.get_recipe(@id)
  erb :recipe
end

get '/search' do

end