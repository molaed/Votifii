class ApplicationController < ActionController::Base
    require 'rest-client'
    require 'json'

    helper_method :render_pic

    def render_pic
       response = RestClient.get "https://dog.ceo/api/breeds/image/random"
        
       hash = JSON.parse(response)

       @link = hash["message"]
    end
end
