class InvalidCardError < StandardError
end

class Card


  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "10",
    :queen => "10",
    :king  => "10",
    :ace   => "1"
  }

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.values
    VALUE_STRINGS.keys
  end


  attr_reader :suit, :value

  def initialize(suit, value)
    unless Card.suits.include?(suit) && Card.values.include?(value)
      raise InvalidCardError
    end

    @suit = suit
    @value = value
  end


end
