require_relative 'deck'

class Hand

  def initialize(cards)
    @player_cards = cards
  end



end

hand = Hand.new([Card.new(:diamonds, :five), Card.new(:clubs, :queen), Card.new(:hearts, :queen),
              Card.new(:diamonds, :queen), Card.new(:spades, :queen)
              ])
p hand.four_of_a_kind?
