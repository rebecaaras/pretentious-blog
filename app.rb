require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'erb' # templating language

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/contact' do
  erb :contact
end