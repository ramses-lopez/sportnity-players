namespace :data do
	desc "Extaer los eventos a partir de los matches"
	task matches: :environment do
		id = "objectId"
		matches = get('Match/?where={"objectId":{"$in":["mVrNirrZv7","uzGKHkiunx","dTu51qCMgk"]}}', debug: true)["results"]
		puts matches.size
	end

	desc "Extrae los datos del partido"
	task player_match_event: :environment do
		id = "objectId"

		response = get('Player_Match_Event/?order=createdAt&include=matchId,teamId,eventId,playerId&where={"matchId":{"__type":"Pointer","className":"Match","objectId":"mVrNirrZv7"}}')
		results = response["results"]

		start_time = Time.now

		team_a_id = results.first["matchId"]["teamA"]["objectId"]
		team_b_id = results.first["matchId"]["teamB"]["objectId"]

		goals_a_1 = 0
		goals_b_1 = 0
		goals_a_2 = 0
		goals_b_2 = 0
		second_term = false

		results.each do |rp|
			event = rp["eventId"]
			my_player = rp["playerId"]
			my_team = rp["teamId"]


			puts "event: #{event["description"]} (#{ event["key"] }) "
			puts "team: #{my_team["name"]}" unless my_team.nil?
			puts "player: #{my_player["firstName"]} #{my_player["lastName"]}" unless my_player.nil?
			puts "minute: #{rp["eventTimeString"]}"
			puts "--"

			#los eventos estan ordenados por hora y fecha de creacion
			second_term = true if event['key'] == 1

			if event["key"] == 3
				if my_team[id] == team_a_id
					second_term ? goals_a_2+=1 : goals_a_1+=1
				else
					second_term ? goals_b_2+=1 : goals_b_1+=1
				end
			end
		end

		puts "#{team_a_id} (#{goals_a_1+goals_a_2}:#{goals_b_1+goals_b_2}) #{team_b_id}"

		puts "Finalizado en #{(Time.now - start_time)} segundos"
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