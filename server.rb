# required gem includes
require 'sinatra'
require "sinatra/json"
require 'rack-flash'


set :bind, '0.0.0.0' # Vagrant fix
set :port, '4567'

get '/' do
  erb :index
end