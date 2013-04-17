module Kaxxxt
  class Game
    # players            = players in the game
    # kaxxxt             = the kaxxxt object
    # current_player_idx = index, relative to @players,
    #                      of the current player

    attr_accessor :players, :kaxxxt, :current_player_idx, :game_status

    def initialize(players, kaxxxt)
      @players = players
      @kaxxxt = kaxxxt
      @current_player_idx = 0
      @game_status = :running
    end

    def roll
      # 1d6
      rand(6) + 1
    end

    def current_player
      @players[@current_player_idx]
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

    def advance_turn!
      # advance clockwise
      @current_player_idx = index_of_player_at(:right)
      current_player
    end

    def destroy_player_at
    end

    def turn
      # no one has been hit
      turn_hits = @players.collect { |_| 0 }
      # calculate kaxxxt's move
      roll = self.roll
      current_action = @kaxxxt.move(roll)
      # and find our current subject
      current_subject_idx = current_player_idx
      current_subject = player_at(current_subject_idx)
      # and the game is afoot
      turn_status = :running
      puts "#{current_subject.name} rolled a #{roll}"

      # while we're in the neighborhood, play
      while turn_status == :running
        turn_hits[current_subject_idx] += 1

        if turn_hits[current_subject_idx] >= 3
          destroy_player_at(@current_player_idx)
          turn_status = :stopped
          next
        end

        response = current_subject.respond_to(current_action)

        # terminal can be:
        # - took damage
        # - repaired
        # otherwise, you are passing on a laser
        if response == [:terminal]
          turn_status = :stopped
        else
          # passing on a laser
          # response is a two-tuple
          action, subject = response

          # the loop terminates if we're attacking
          # kaxxxt, so we need a special case
          if subject == :kaxxxt
            turn_status = :stopped
            @kaxxxt.receive(action)
          else
            current_action = action
            current_subject_idx = index_of_player_at(subject)
          end
        end
      end

      # game ending conditions
      if !@kaxxxt.alive?
        # current_subject_idx wins
        @game_status = :stopped
        puts "Kaxxxt is dead! Long live Kaxxxt! Also, #{current_subject.name} wins."
      elsif @players.count == 1
        @game_status = :stopped
        puts "Kaxxxt is dead! Long live Kaxxxt! Also, #{@players.first.name} wins."
      elsif @players.count == 0
        @game_status = :stopped
        puts "Kaxxxt wins! Long live Kaxxxt!"
      else
        # next persons turn!
        advance_turn!
      end
    end

    def run
      while @game_status == :running
        if @current_player_idx == 0
          @players.each { |player| player.configure_machine }
        end
        turn
      end
    end
  end

  class Kaxxxt
    attr_accessor :hp

    def initialize
      @hp = 50
    end

    def alive?
      @hp > 0
    end

    def receive(action)
      case action
      when :hit5
        @hp -= 5
      when :hit10
        @hp -= 10
      when :hit20
        @hp -= 20
      end
    end

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

