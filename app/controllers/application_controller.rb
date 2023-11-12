class ApplicationController < ActionController::Base
    require 'rest-client'
    require 'json'
    
    before_action :render_pic

    def render_pic
        #response = RestClient.get "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
        
        #hash = JSON.parse(response) #parse creates a hash with {key: message, value, }

        #@image = hash["url"]
    end
    
end
