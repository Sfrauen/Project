  require 'nokogiri'
  require 'open-uri'
  require 'pry'

class Destinations

  def initialize
    html = open('http://travel.usnews.com/Rankings/Worlds_Best_Vacations')
    @nokogiri_doc = Nokogiri::HTML(html)
    @locations_sites = []
    @nokogiri_doc.css("div#main a.see-more").each do |descr|
      @locations_sites << descr.attr("href")
    end
    @all_locations = self.all_locations
  end

  def top_25_destinations
    @destinations = []
    @nokogiri_doc.css("div.dest-name a").each do |destination|
    @destinations << destination.text
    end
    @destinations
  end

  def destination_description
    @descriptions_array = []
    @locations_sites.each do |para|
      link = 'http://travel.usnews.com' + para
      location_link = open(link)
      @nokogiri_location = Nokogiri::HTML(location_link)
      description = @nokogiri_location.css("div#main p").children.text
      @descriptions_array << description
    end
      @descriptions_array
  end

  def all_locations
    @all_locations = {}
    top_25_destinations.each_with_index do |item, i|
      @all_locations[item] = destination_description[i]
      puts "scraping #{item}"
    end
    @all_locations
  end

  def beaches
    @beaches = {}
    @all_locations.each_key do |place|
      if place == "Maui" || place == "Puerto Rico" || place == "Barcelona" || place == "Rio de Janeiro" || place == "Bora Bora" || place == "U.S. Virgin Islands" || place == "Maldives" || place == "Crete" || place == "Bahamas" || place == "Cape Town" 
        @beaches[place] = @descriptions_array[@destinations.index(place)]
      end
    end
    @beaches
  end

  def ski
    @ski = {}
    @all_locations.each_key do |place|
      if place == "Vancouver" || place == "Zurich" || place == "Montreal"
        @ski[place] = @descriptions_array[@destinations.index(place)]
      end
    end
    @ski
  end

  def cities
    @cities = {}
    @all_locations.each_key do |place|
      if place == "Paris" || place == "London" || place == "Puerto Rico" || place == "New York City" || place == "San Francisco" || place == "Sydney" || place == "Cape Town" || place == "Crete" || place == "Washington D.C." || place == "Budapest" || place == "Jerusalem" || place == "Hong Kong"   
        @cities[place] = @descriptions_array[@destinations.index(place)]
      end
    end
    @cities
  end

  def forest
    @forest = {}
    @all_locations.each_key do |place|
      if place == "Yellowstone"
        @forest[place] = @descriptions_array[@destinations.index(place)]
      end
    end
    @forest
  end

end
