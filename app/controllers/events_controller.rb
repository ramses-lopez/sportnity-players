class EventsController < ApplicationController

	def  index
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        response = HTTParty.get('https://api.parse.com/1/classes/Event', headers: {
            "X-Parse-Application-Id" => @app_id,
            "X-Parse-REST-API-Key" => @rest_api_key,
            "Content-Type" => "application/json"})

        @results = response["results"]
	end
end
