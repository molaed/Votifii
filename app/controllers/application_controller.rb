class ApplicationController < ActionController::Base
    require 'rest-client'
    require 'json'
    #Breaks everything with 'too many requests'. Maybe because of demo?
    #before_action :render_pic

    #def render_pic
    #    response = RestClient.get "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
        
    #    hash = JSON.parse(response) #parse creates a hash with {key: message, value, }

    #    @image = hash["10"]
    #end
end
