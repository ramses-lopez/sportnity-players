class PlayersController < ApplicationController
    require 'net/http'

    def index
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        #curl -X GET
        # -H "X-Parse-Application-Id: Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        # -H "X-Parse-REST-API-Key: kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"
        # -H "Content-Type: application/json"

        response = HTTParty.get('https://api.parse.com/1/classes/Player', headers: {
            "X-Parse-Application-Id" => @app_id,
            "X-Parse-REST-API-Key" => @rest_api_key,
            "Content-Type" => "application/json"})

        @results = response["results"]
    end

    def show
    end

    def new
    end

    def create

        data = {firstName: 'test', lastName: 'name', photoUrl: 'url'}

        response = HTTParty.post("https://api.parse.com/1/classes/Player",
            headers: {"Content-Type" => "application/json", "X-Parse-Application-Id" => @app_id, "X-Parse-REST-API-Key" => @rest_api_key},
            body: data.to_json)

        debugger

        logger.debug response.inspect
    end

    def edit
    end

    def update
    end
end
