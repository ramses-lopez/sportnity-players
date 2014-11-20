module PlayersHelper
	def random_quip(name)
		name = name.capitalize
		quip = case (1..6).to_a.sample
		when 1
			"Some interesting info about #{name}"
		when 2
			"#{name} is a pro-player that"
		when 3
			"Here's some background on #{name}"
		when 4
			"Read more about #{name}'s feats in"
		when 5
			"Follow #{name} on twitter"
		when 6
			"#{name} started playing with his team on"
		end

		quip
	end
end
