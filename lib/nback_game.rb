class NbackGame
	def initialize(n, game_mode, round_attributes)
		@n = n
		@game_mode = game_mode
		@round_attributes = round_attributes
		@rounds = []
	end

	def generate_rounds
		@n + 20.times do
			@rounds << Round.new(round_number, @round_attributes)
		end
	end
end


class Round
	def initialize(round_number, round_attributes)
		@round_number = round_number
		@color = select_color(round_attributes[:color])
		@sound = select_sound(round_attributes[:sound])
		@position = select_position(round_attributes[:position])
	end
end