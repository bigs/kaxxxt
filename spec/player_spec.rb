require_relative '../lib/kaxxxt/player'

describe Player do
  before :all do
    @player = Player.new(:name => "N. Harold Cham")
  end

  player.name.should eq("N. Harold Cham")
end

