require './lib/player'
require './lib/deck'
require './lib/card'

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    round_1 = @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
    round_2 = @player1.deck.cards[2].rank == @player2.deck.cards[2].rank
    if round_1 && round_2
      :mutually_assured_destruction
    elsif round_1
      :war
    else
      :basic
    end
  end

  def winner
    if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      @player1
    elsif @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
      @player2
    end
  end
end
