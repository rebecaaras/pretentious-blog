require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'erb' # templating language
require 'kramdown'

# class Post
#   parsed_content = 'blablabla'
# 
#   # será que tem como eu parsear o html para um json e capturar o conteúdo de cada tag?
#   @title
#   @date
#   @tags
#   @slug
#   @body
# 
#   def generate_slug;end 
# 
#   def self.all;end # itera sobre todos os arquivos em /posts
# end
# 
# def load_posts
#   Kramdown::Document.new(File::read("posts/example-post.md")).to_html
# end

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

get '/pages/jap' do
  @page_title="Japanese"
  erb :"pages/jap"
end

get '/post' do
  @page_title="Example post"
  @tags = ["ruby", "sinatra", "blog"]
  @date = Date.today
  @slug = :some_slug_here
  @body = Kramdown::Document.new(File.read("posts/example_post_body.md")).to_html
  # #{@slug}.gsub!("_","-")
  erb :'post'
end