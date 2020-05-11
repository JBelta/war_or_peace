require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

@suit = [:diamond, :heart, :club, :spade]
value_no = [*2..10]
value_str = value_no.map {|no| no.to_s}
value_str << ["Jack", "Queen", "King", "Ace"]
value = value_str.flatten
rank = [*2..14]
@v_r = value + rank
#require 'pry'; binding.pry

@cards = [].tap do |cards|
  @suit.each do |suit|
     @v_r.find do |object|
    if object.is_a?(Integer)
      rank = object
      #Not returning first, but all integers
    elsif object.is_a?(String)
      value = object
    end
     #@rank.each {|r| r}
      #require 'pry'; binding.pry
    cards << Card.new(suit, value, rank)
    require 'pry'; binding.pry
      end
    end
  end
#end
require 'pry'; binding.pry
p @cards
