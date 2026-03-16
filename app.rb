require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'erb' # templating language
require 'kramdown'

class Post
  attr_reader :title, :date, :body, :tags, :slug
  
  def initialize(post_hash)
    @title = post_hash[:title]
    @date = Date.parse(post_hash[:date])
    @body = post_hash[:body]
    @tags = tags_array(post_hash[:tags])
    @slug = generate_slug(title)
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

  def tags_array(tags)
    tags.gsub(" ", "").split(",")
  end

  def generate_slug(title)
    title.strip.downcase
    .gsub(/(&|&amp;)/, ' and ')
    .gsub(/[\s\.\/\\]/, '-')
    .gsub(/[^\w-]/, '')
    .gsub(/[-_]{2,}/, '-')
    .gsub(/^[-_]/, '')
    .gsub(/[-_]$/, '')
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
  erb :'post'
end