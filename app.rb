require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'erb' # templating language
require 'kramdown'

class Post
  attr_reader :title, :date, :body
  
  def initialize(post_hash)
    @title = post_hash[:title]
    @date = Date.parse(post_hash[:date])
    @body = post_hash[:body]
  end

  def self.parse(file)
    text = File.read(file).strip
    meta, body = text.split('---')[1..2]

    post_hash = {}
    meta.lines.map(&:strip).reject(&:empty?).collect do |line|
      k, v = line.split(":")
      post_hash[k.strip.to_sym] = v.strip
    end
    post_hash[:body] = body.strip
    new(post_hash)
  end
end

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