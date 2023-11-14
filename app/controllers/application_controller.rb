class ApplicationController < ActionController::Base
    # Include necessary libraries for making HTTP requests and parsing JSON.
    require 'rest-client'
    require 'json'

    # Declare a helper method that can be used in views to render a random dog picture.
    helper_method :render_pic

    # Define the helper method to fetch a random dog picture from an external API.
    def render_pic
       # Make a GET request to the Dog CEO API to obtain a random dog image URL.
       response = RestClient.get "https://dog.ceo/api/breeds/image/random"
        
       # Parse the JSON response into a hash.
       hash = JSON.parse(response)

       # Extract the image URL from the hash and assign it to the instance variable @link.
       @link = hash["message"]
    end
end