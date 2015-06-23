require_relative './tie_breaker'

module PokerHands
  def straight_flush?
    @player_cards.all? do |card|
      card.suit == @player_cards[0].suit
    end
    # TODO not done
  end

  def four_of_a_kind?
    of_a_kind?(4)
  end

  def three_of_a_kind?

  def of_a_kind?(count)
    @player_cards.each do |card|
      counter = 0
      @player_cards.each do |piece|
        counter += 1 if card.value == piece.value
      end
      return card.value if counter == count
    end
    false
  end
end
