module Kaxxxt
  class Game
    attr_accessor :players, :kaxxxt, :current_player_idx,
                  :turn_hits

    def roll
      # 1d6
      rand(6) + 1
    end

    def current_player
      @players[@current_player_idx]
    end

    def initialize_turn_hits
      @turn_hits = players.reduce({}) do |memo, player|
        memo[player.name] = 0 
      end
    end

    def index_of_player_at(position)
      case position
      when :left
        (@current_player_idx + 3) % 4
      when :right
        (@current_player_idx + 1) % 4
      when :across
        (@current_player_idx + 2) % 4
      end
    end

    def player_at(position)
      @players[index_of_player_at(position)]
    end

    def turn
      initialize_turn_hits
      turn_status = :running
      while turn_status == :running
        response = current_player.respond_to(roll)
      end
    end

    def process_response
    end
  end

  class Kaxxxt
    attr_accessor :hp

    def move(roll)
      case roll
      when 1
        :red_laser
      when 2
        :blue_laser
      when 3, 4
        :green_laser
      when 5
        :reroll
      when 6
        :direct_hit
      else
      end
    end
  end
end

