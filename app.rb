require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'erb' # templating language

get '/' do
  erb :index
end

get '/about' do
  @page_title="About"
  erb :about
end

get '/contact' do
  @page_title="Contact"
  erb :contact
end