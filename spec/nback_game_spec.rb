require_relative "../lib/nback_game"

describe "NBackGame" do
	before(:each) do
		@new_game = NbackGame.new(2, 'single', { color: ["blue", "red", "green", "orange"], sound: ["/sounds/cat.mp3", "/sounds/dog.mp3", "/sounds/cat.mp3"], position: [1, 2, 1, 4]})
	end

	context 'when a user is presented with an nback match' do
		it "records a correct guess if the user responds" do
			@new_game.generate_rounds
			@round = 2

			until @response == true
				@round += 1
				@response = @new_game.evaluate_users_guess(@round, 'color')
			end

			expect(@new_game.show_round_attributes(@round)[:color]) ===  @new_game.show_round_attributes(@round - 2)[:color]
		end
	end
end