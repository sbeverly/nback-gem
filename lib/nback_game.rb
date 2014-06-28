class NbackGame
	def initialize(n, game_mode, round_attributes)
		@n = n
		@game_mode = game_mode
		@round_attributes = round_attributes
		@rounds = []
	end

	def generate_rounds
		@n + 20.times do
			@round_number = 0
			@rounds << Round.new(@round_number, @round_attributes)
			@round_number += 1
		end
	end

	def evaluate_users_guess(current_round, attribute)
		@current_round = @rounds[current_round - 1]
		@nback_round = @rounds[current_round - 1 - @n]

		puts @current_round.round_attributes[:color]
		puts @nback_round.round_attributes[:color]

		if @current_round.round_attributes[attribute.to_sym] == @nback_round.round_attributes[attribute.to_sym] 
			@current_round.round_attributes["#{attribute}_correct".to_sym] = true
		else
			@current_round.round_attributes["#{attribute}_correct".to_sym] = false
		end
	end

	def evaluate_non_response(current_round)
		@current_round = @rounds[current_round - 1]
		@nback_round = @rounds[current_round - 1 - @n]

		@round_attributes.each_key do |attribute|
			if @current_round.round_attributes["#{attribute}_correct".to_sym] == nil
				if @current_round.round_attributes[attribute.to_sym] != @nback_round.round_attributes[attribute.to_sym]
					@current_round.round_attributes["#{attribute}_correct".to_sym] = true
				else
					@current_round.round_attributes["#{attribute}_correct".to_sym] = false
				end
			end
		end
		return @current_round
	end

	def show_round_attributes(round_number)
		puts @rounds[round_number - 1].round_attributes
		@rounds[round_number - 1].round_attributes
	end 
end

class Round
	attr_accessor :round_number, :round_attributes

	def initialize(round_number, round_attributes)
		@round_number = round_number
		@round_attributes = { 	color: round_attributes[:color].sample, color_correct: nil, 
								sound: round_attributes[:sound].sample, sound_correct: nil,
								position: round_attributes[:position].sample, position_correct: nil
							}
		p @round_attributes[:color]
	end
end