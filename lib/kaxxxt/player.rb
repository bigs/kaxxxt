module Kaxxxt
  class Player
    # name    = player's name
    # hp      = remaining hit points
    # cards   = their unplayed hand, a list
    # machine = their played hand, a list
    #           of lists (rows)
    attr_accessor :name, :hp, :cards, :machine,
                  :received_count

    def initialize(options)
      [:name, :hp, :cards].each do |opt|
        if options[opt]
          self.send("#{opt}=", options[opt])
        end
      end
      @received_count = 0
      @machine = []
    end

    def receive(action)
      responses = []
      @received_count += 1
      if @received_count >= 3
        @hp = 0
        respones.push([:terminal, :died_from_hits, []])
      else
        # evaluate the machine!
        machine.each do |row|
          conditional_card = row.first
          if conditional_card.action == action
            row[1..-1].each do |action_card|
              responses.push(action_card.respond(action))
            end
          elsif conditional_card == :mirror
            responses.push([:hit_10, :kaxxxt])
          else
            [:terminal, :took_damage, [10]]
          end
        end
      end
    end
  end
end

