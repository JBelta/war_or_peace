require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
  end

  def test_it_exist
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_type_basic
    assert_equal :basic, @turn.type
  end

  def test_type_war
    @deck2.remove_card
    assert_equal :war, @turn.type
  end

  def test_type_mutually_assured_destruction
    @card7 = Card.new(:diamond, '8', 8)
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
    @deck2.remove_card
    assert_equal :mutually_assured_destruction, @turn.type
  end

  def test_winner
    assert_equal @player1, @turn.winner

    @deck1.remove_card
    @deck2.remove_card
    assert_equal @player2, @turn.winner
  end

  def test_pile_of_cards_basic
    @turn.pile_of_cards
    assert_equal [@card1, @card3], @turn.spoils_of_war
  end

  def test_pile_of_cards_war
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
    assert_equal :war, @turn.type

    @turn.pile_of_cards
    assert_equal [@card1, @card2, @card5, @card4, @card3, @card6], @turn.spoils_of_war
  end

  def test_pile_of_cards_mutually_assured_destruction
    @card6 = Card.new(:diamond, '8', 8)
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)
    assert_equal :mutually_assured_destruction, @turn.type
    assert_equal "No Winner", @turn.winner

    @turn.pile_of_cards
    assert_equal [], @turn.spoils_of_war
    assert_equal @deck1, @player1.deck
    assert_equal @deck2, @player2.deck
  end
end
