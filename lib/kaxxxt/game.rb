module Kaxxxt
   class Game
    attr_accessor :players, :kaxxxt, :current_player

    def roll
      # 1d6
      rand(6) + 1
    end
  end

  class Kaxxxt
    attr_accessor :hp

    def move(roll)
      case roll
      when 1
        #red
      when 2
        #blue
      when 3, 4
        #green
      when 5
        #reroll
      when 6
        #direct hit
    end
  end
end

