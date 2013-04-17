module Kaxxxt
  class Player
    # name    = player's name
    # hp      = remaining hit points
    # cards   = their unplayed hand, a list
    # machine = their played hand, a list
    #           of lists (rows)
    attr_accessor :name, :hp, :cards, :machine

    def initialize(options)
      [:name, :hp, :cards, :machine].each do |opt|
        if options[opt]
          self.send("#{opt}=", options[opt])
        end
      end
    end
  end
end

