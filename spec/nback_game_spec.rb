require_relative "../lib/nback_game"

describe "NBackGame" do
	before(:each) do
		@new_game = NbackGame.new(2, 'single', { color: ["blue", "red", "green", "orange"], sound: ["/sounds/cat.mp3", "/sounds/dog.mp3", "/sounds/cat.mp3"], position: [1, 2, 1, 4]})
		@new_game.generate_rounds
		@round = 0
	end

	it "records a correct guess if the user responds" do
		until @response == true
			@round += 1
			@response = @new_game.evaluate_users_guess(@round, 'color')
		end

		expect(@new_game.show_round_attributes(@round)[:color]).to eq(@new_game.show_round_attributes(@round - 2)[:color])
		expect(@new_game.show_round_attributes(@round)[:color_correct]).to eq(true)
	end

	it "records an incorrect guess if the user indicates a match when there was none" do
		until @response == false
			@round += 1
			@response = @new_game.evaluate_users_guess(@round, 'color')
		end

		expect(@new_game.show_round_attributes(@round)[:color]).not_to eq(@new_game.show_round_attributes(@round - 2)[:color])
		expect(@new_game.show_round_attributes(@round)[:color_correct]).to eq(false)
	end

	it "records whether a users non-response was correct if there is no nback match on the current round" do
		until @new_game.show_round_attributes(@round)[:sound_correct] == true
			@round += 1
			@new_game.evaluate_non_response(@round)
		end

		expect(@new_game.show_round_attributes(@round)[:sound]).not_to eq(@new_game.show_round_attributes(@round - 2)[:sound])
	end
end