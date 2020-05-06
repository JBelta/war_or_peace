require 'minitest/autorun'
require 'minitest/pride'
require 'lib/deck'
require 'lib/card'

class DeckTest < Minitest::Test
  def test_it_exists
    deck = Deck.new(cards)

    assert_instance_of Deck, deck
  end
end
