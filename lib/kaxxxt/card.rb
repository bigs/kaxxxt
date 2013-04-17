module Kaxxxt
  class Card
    attr_accessor :orientation

    def action
      :pass
    end

    def respond(attack)
      :pass
    end

    def execute_on(color, attack)
      case attack
      when color
        :execute
      else
        :pass
      end
    end
  end

  class RedLaserCard < Card
    def action
      :red_laser
    end

    def respond(attack)
      execute_on(:red_laser, attack)
    end
  end

  class BlueLaserCard < Card
    def action
      :blue_laser
    end

    def respond(attack)
      execute_on(:blue_laser, attack)
    end
  end

  class GreenLaserCard < Card
    def action
      :green_laser
    end

    def respond(attack)
      execute_on(:green_laser, attack)
    end
  end
end

