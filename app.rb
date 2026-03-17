require 'rubygems'
require 'sinatra'
require 'erb'
require 'kramdown'

class Post
  attr_reader :title, :date, :body, :tags, :slug
  
  def initialize(filename)
    post_hash = parse(filename)

    @title = post_hash[:title]
    @date = Date.parse(post_hash[:date])
    @body = post_hash[:body]
    @tags = tags_array(post_hash[:tags])
    @slug = generate_slug(title)
  end

  def self.all
    posts_dir = "posts/"
    Dir::new(posts_dir).children.collect do |filename|
      new("#{posts_dir}#{filename}")
    end
  end

  def parse(filename)
    text = File.read(filename).strip
    meta, body = text.split('---')[1..2]

    post_hash = {}
    meta.lines.map(&:strip).reject(&:empty?).collect do |line|
      k, v = line.split(":")
      post_hash[k.strip.to_sym] = v.strip
    end
    post_hash[:body] = Kramdown::Document.new(body.strip).to_html
    post_hash
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
    .to_sym
  end

  def self.find_by_slug(slug)
    Post.all.select { |post| post.slug == slug}[0]
  end
end

get '/' do
  @posts = Post.all
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

get '/posts/:slug' do
  @post = Post.find_by_slug(:"#{params[:slug]}")
  erb :'post'
end