class MatchsController < ApplicationController

  before_action :set_parse_keys

  def  index
    response = HTTParty.get(URI.encode("https://api.parse.com/1/classes/Match"), headers: {
        "X-Parse-Application-Id" => @app_id,
        "X-Parse-REST-API-Key" => @rest_api_key,
        "Content-Type" => "application/json"})

    @results = response["results"]
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def events
        # response = HTTParty.get("https://api.parse.com/1/classes/Player_Match_Event"), headers: {
        #     "X-Parse-Application-Id" => @app_id,
        #     "X-Parse-REST-API-Key" => @rest_api_key,
        #     "Content-Type" => "application/json"})
        # @results = response["results"]
  end

  private
    def set_parse_keys
        @app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
        @rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"
    end

end
