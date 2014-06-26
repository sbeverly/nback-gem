class NbackGame
	def initialize(n, game_mode, round_attributes)
		@n = n
		@game_mode = game_mode
		
		# Hash containing colors, sounds and positions, i.e. { colors: ['blue, 'red'], 
		#																											 sounds: ['/sounds/cat.mp3', '/sounds/dog.mp3']
		# 																										 positions: [1, 2, 3, 4]
		# 																										}

		@round_attributes = round_attributes
		@rounds = []
	end

	def generate_rounds
		@n + 20.times do
			@rounds << Round.new(round_number, @round_attributes)
		end
	end

	def evaluate_users_guess(current_round, attribute)
		@current_round = @rounds[current_round]
		@nback_round = @rounds[current_round - @n]

		if @current_round.round_attributes[attribute.to_sym] == @nback_round.round_attributes[attribute.to_sym] 
			case attribute
			when 'color'
				@current_round.round_attributes[:color_correct] = true
			when 'sound'
				@current_round.round_attributes[:sound_correct] = true
			when 'position'
				@current_round.round_attributes[:position_correct] = true
			end
		else
			case attribute
			when 'color'
				@current_round.round_attributes[:color_correct] = false
			when 'sound'
				@current_round.round_attributes[:sound_correct] = false
			when 'position'
				@current_round.round_attributes[:position_correct] = false
			end
		end
	end

	def evaluate_non_response(current_round)
		@current_round = @rounds[current_round]
		@nback_round = @rounds[current_round - @n]

		@round_attributes.each_key |attribute| do
			if @current_round.round_attributes["#{attribute}_correct".to_sym] == nil
				if @current_round.round_attributes[attribute.to_sym] != @nback_round.round_attributes[attribute.to_sym]
					@current_round.round_attributes["#{attribute}_correct".to_sym] = true
				else
				@current_round.round_attributes["#{attribute}_correct".to_sym] = false
				end
			end
		end
	end
end

class Round
	def initialize(round_number, round_attributes)
		@round_number = round_number
		@round_attributes = { color: round_attributes[:colors].sample, color_correct: nil 
													sound: round_attributes[:sounds].sample, sound_correct: nil
													position: round_attributes[:positions].sample, position_correct: nil
												}
	end
end


