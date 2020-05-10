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
    if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank
      @player1
    elsif @player1.deck.cards[0].rank < @player2.deck.cards[0].rank
      @player2
    elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
      if @player1.deck.cards[2].rank > @player2.deck.cards[2].rank
        @player1
      elsif @player1.deck.cards[2].rank < @player2.deck.cards[2].rank
        @player2
      end
    else
      "No Winner"
    end
  end

  def pile_of_cards
    round_1 = @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
    round_2 = @player1.deck.cards[2].rank == @player2.deck.cards[2].rank
    if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank || @player1.deck.cards[0].rank < @player2.deck.cards[0].rank
      @spoils_of_war << @player1.deck.cards[0]
      @spoils_of_war << @player2.deck.cards[0]
    elsif round_1
      @spoils_of_war << @player1.deck.cards[0..2]
      @spoils_of_war << @player2.deck.cards[0..2]
      @spoils_of_war.flatten!
    end
  end
end
