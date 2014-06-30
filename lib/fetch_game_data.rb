class DataFetcher
  attr_accessor :round_attributes, :game_data

  def initialize(game_data, game_mode)
    @game_data = game_data
    @game_mode = game_mode
    @round_attributes = {}
  end

  def fetch_game_data(game_mode)
        @colors_array = []
        @sounds_array = []
        @positions_array = [1,2,3,4];

        @total_stimuli = 4
        @stimuli_count = 1
        while @stimuli_count < @total_stimuli + 1
          @colors_array << game_data[:colors][@stimuli_count]
              @sounds_array << game_data[:sounds][@stimuli_count]
              @stimuli_count += 1
        end

        if game_mode == 'Single'
              @round_attributes[:positions] = @positions_array
        elsif game_mode == 'Dual'
              @round_attributes[:positions] = @positions_array
              @round_attributes[:sounds] = @sounds_array
        else game_mode == 'Triple'
              @round_attributes[:positions] = @positions_array
              @round_attributes[:sounds] = @sounds_array
              @round_attributes[:colors] = @colors_array
        end
    end
  end
