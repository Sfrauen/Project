require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require 'pry'
require_relative "lib/Final_Project_Scrape.rb"

get '/' do
  erb :Final_Project_Scrape
end


post '/result' do
  @trip = Destinations.new
  @weather = params[:weather]
  @landscape_setting = params[:landscape_setting]
  @lifestyle = params[:lifestyle]
  erb :result
end