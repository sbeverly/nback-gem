class NbackGame
	def initialize(n, round_attributes)
		@n = n
		@game_mode = game_mode
		@round_attributes = round_attributes
		@rounds = []
	end

	def generate_rounds
		@round_number = 1
		@n + 20.times do
			@rounds << Round.new(@round_number, @round_attributes)
			@round_number += 1
		end
	end

	def evaluate_users_guess(current_round_number, attribute)
		@current_round = @rounds[current_round_number - 1]
		@nback_round = @rounds[current_round_number - 1 - @n]

		if current_round_number > @n
			if @current_round.round_attributes[attribute.to_sym] == @nback_round.round_attributes[attribute.to_sym]
				@current_round.round_attributes["#{attribute}_correct".to_sym] = true
			else
				@current_round.round_attributes["#{attribute}_correct".to_sym] = false
			end
		else
			@current_round.round_attributes["#{attribute}_correct".to_sym] = false
		end
	end

	def evaluate_non_response(current_round_number)
		@current_round = @rounds[current_round_number - 1]
		@nback_round = @rounds[current_round_number - 1 - @n]

		if current_round_number < @n
			@round_attributes.each_key do |attribute|
				if @current_round.round_attributes["#{attribute}_correct".to_sym] == nil
					if @current_round.round_attributes[attribute.to_sym] != @nback_round.round_attributes[attribute.to_sym]
						@current_round.round_attributes["#{attribute}_correct".to_sym] = true
					end
				end
			end
		else
			@round_attributes.each_key do |attribute|
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

	def show_round_attributes(round_number)
		@rounds[round_number - 1].round_attributes
	end
end

class Round
	attr_accessor :round_number, :round_attributes

	def initialize(round_number, round_attributes)
		@round_number = round_number
		@round_attributes = { color: round_attributes[:color].sample, color_correct: nil,
								sound: round_attributes[:sound].sample, sound_correct: nil,
								position: round_attributes[:position].sample, position_correct: nil
								}
	end
end

class DataFetcher
	attr_accessor :round_attributes, :game_data

	def initialize(game_mode)
		@game_mode = game_mode
		@round_attributes = {}
	end

	def fetch_game_data(game_mode)
	       @colors_array = []
	       @sounds_arrat = []
	       @positions_array = [1,2,3,4];

	       @total_stimuli = 4
	       @stimuli_count = 1
	       while @stimuli_count < @total_stimuli + 1
	            @colors_array << game_data.colors[@stimuli_count]
	            @sounds_array << game_data.sounds[@stimuli_count]
	            @stimuli_count += 1
	       end

	        if (gameMode === 'Single') {
	            return {positions: positionArr}
	        } else if (gameMode === 'Dual') {
	            this.soundBuilder.buildSounds(soundArr)
	            return {positions: positionArr, sounds: soundArr}
	        } else if (gameMode === 'Triple'){
	            this.soundBuilder.buildSounds(soundArr)
	            return {colors: colorArr, sounds: soundArr, positions: positionArr}
	        }
	    },
  end
