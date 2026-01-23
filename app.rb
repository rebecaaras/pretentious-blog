require 'rubygems'
require 'sinatra' # DSL (Domain Specific Language) for easily building rails web applications
require 'sinatra/activerecord'
require 'erb' # templating language

class Post < ActiveRecord::Base
  validates :title, presence: true, length: {in: 3..50}
  validates :content, presence: true, length: {minimum: 10}
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9-]+\z/}

  default_scope { order(created_at: :desc)}

  before_validation :generate_slug

  def display_date
    created_at.strftime("%d/%m/%Y")
  end

  def excerpt(length=150)
    content.truncate(length, separator: " ", omission: "...")
  end

  private

  def generate_slug
    return if slug.present?

    self.slug = title
      .downcase
      .gsub(/[^a-z0-9\s-]/, '')
      .gsub(/\s+/, '-')
      .gsub(/-+/, '-')
      .strip
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