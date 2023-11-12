class ApplicationController < ActionController::Base
    require 'rest-client'
    require 'json'

    #before_action :render_pic

    def render_pic
       response = RestClient.get "https://picsum.photos/200"
        
       hash = JSON.parse(response)

       @image = hash
    end
end
