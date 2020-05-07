require './lib/deck'
require './lib/card'

class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = []
  end
end
