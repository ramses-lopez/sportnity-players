namespace :data do
  desc "Extrae los datos del partido"
  task player_match_event: :environment do

  	puts "Se obtienen los tipos de evento existentes en parse"

  	id = "objectId"

  	events = get_event_type

    response = get('Player_Match_Event/?where={"matchId":{"__type":"Pointer","className":"Match","objectId":"mVrNirrZv7"}}')

    results = response["results"]

    puts "Match mVrNirrZv7 #{results.size} eventos"

    results.each do |result|

#                <playersEvents>
#                   <eventType>1</eventType>
#                   <idPlayer>498</idPlayer>
#                   <minute>45</minute>
#                </playersEvents>

		rp = get("Player_Match_Event/#{result[id]}")

		my_event = events.select {|e| e[id] == rp["eventId"][id]}.first
		my_player = rp["playerId"].nil? ? nil : get("Player/#{rp["playerId"][id]}")
		my_team = rp["teamId"].nil? ? nil : get("Team/#{rp["teamId"][id]}")

		#puts "event: #{rp["eventId"]}"
		puts "event -> #{my_event["description"]} (#{ my_event["key"] }) "
		puts "team: #{my_team["name"]}" unless my_team.nil?
		puts "player: #{my_player["firstName"]} #{my_player["lastName"]}" unless my_player.nil?
		puts "minute: #{rp["eventTimeString"]}"

		puts "--"

		#rp.parsed_response.each do |key|
			#puts "#{key}: #{rp[key]},"
		#end

    end

  end

  #obtener los tipos de evento
  def get_event_type
  	rp = get('Event')
  	rp["results"]
  end

  def get(endpoint, options = nil)
  	base_uri = "https://api.parse.com/1/classes"
    app_id = "Mf3LVmQ9E5eN7VJ3rNG7RjcipryYzf0YZ0lL0WEU"
    rest_api_key = "kgkUqdFmxtisIazLaEUToaTAlcTiQTTBusWJ9f9b"
    headers = {"X-Parse-Application-Id" => app_id, "X-Parse-REST-API-Key" => rest_api_key, "Content-Type" => "application/json"}

    puts "debug: #{URI.encode("#{base_uri}/#{endpoint}")}" unless options.blank? || options[:debug] == false

    response = HTTParty.get(URI.encode("#{base_uri}/#{endpoint}"), headers: headers)
  end

end

# <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://webservice.sportnity.com/">
#    <soapenv:Header/>
#    <soapenv:Body>
#       <web:sendMatchReport>
#          <matchReport>
#             <game>
#                <localData>
#                   <goals>8</goals>
#                   <goals_extratime>4</goals_extratime>
#                   <goals_firstpart>2</goals_firstpart>
#                   <goals_penalty>1</goals_penalty>
#                   <goals_secondpart>1</goals_secondpart>
#                   <idTeam>49</idTeam>
#                   <played>0</played>
#                </localData>
#                <playersEvents>
#                   <eventType>1</eventType>
#                   <idPlayer>498</idPlayer>
#                   <minute>45</minute>
#                </playersEvents>
#                <playersEvents>
#                   <eventType>1</eventType>
#                   <idPlayer>498</idPlayer>
#                   <minute>16</minute>
#                </playersEvents>
#                <playersEvents>
#                   <eventType>1</eventType>
#                   <idPlayer>498</idPlayer>
#                   <minute>11</minute>
#                </playersEvents>
#                <visitorData>
#                   <goals>10</goals>
#                   <goals_extratime>5</goals_extratime>
#                   <goals_firstpart>2</goals_firstpart>
#                   <goals_penalty>2</goals_penalty>
#                   <goals_secondpart>1</goals_secondpart>
#                   <idTeam>50</idTeam>
#                   <played>14</played>
#                </visitorData>
#             </game>
#             <idUser>236</idUser>
#             <local>55</local>
#             <visitante>66</visitante>
#          </matchReport>
#       </web:sendMatchReport>
#    </soapenv:Body>
# </soapenv:Envelope>