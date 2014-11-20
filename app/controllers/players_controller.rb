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
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        data = {firstName: params[:first_name],
            lastName: params[:last_name],
            photoUrl: params[:image_url]}

        response = HTTParty.post("https://api.parse.com/1/classes/Player",
            headers: {"Content-Type" => "application/json", "X-Parse-Application-Id" => @app_id, "X-Parse-REST-API-Key" => @rest_api_key},
            body: data.to_json)

        redirect_to players_path, flash: {success: "Player created"}
    end

    def edit
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        response = HTTParty.get("https://api.parse.com/1/classes/Player/#{params[:id]}",
            headers: {"Content-Type" => "application/json", "X-Parse-Application-Id" => @app_id, "X-Parse-REST-API-Key" => @rest_api_key})

        data = response.parsed_response

        @first_name = data["firstName"]
        @last_name = data["lastName"]
        @image_url = data["photoUrl"]
        @object_id = data["objectId"]
    end

    def update
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        data = {firstName: params[:first_name],
            lastName: params[:last_name],
            photoUrl: params[:image_url]}

        response = HTTParty.put("https://api.parse.com/1/classes/Player/#{params[:id]}",
            headers: {"Content-Type" => "application/json", "X-Parse-Application-Id" => @app_id, "X-Parse-REST-API-Key" => @rest_api_key},
            body: data.to_json)

        redirect_to players_path, flash: {success: "Player updated"}
    end

    def destroy
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"

        response = HTTParty.delete("https://api.parse.com/1/classes/Player/#{params[:id]}",
            headers: {"Content-Type" => "application/json", "X-Parse-Application-Id" => @app_id, "X-Parse-REST-API-Key" => @rest_api_key})

        redirect_to players_path, flash: {success: "Player deleted"}
    end
end
