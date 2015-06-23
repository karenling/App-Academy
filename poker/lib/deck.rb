require_relative 'card'

class Deck
  attr_reader :card_deck

  def initialize
    @card_deck = []
    create_deck
  end

  def create_deck
    card_deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        @card_deck << Card.new(suit, value)
      end
    end
  end

end

# card = Deck.new
# puts card.card_deck.count


# require_relative 'card'
#
# class Deck
#   attr_reader :card_deck
#
#   def initialize(card_deck)
#     @card_deck = card_deck
#   end
#
#   def self.create_deck
#     card_deck = []
#     Card.suits.each do |suit|
#       Card.values.each do |value|
#         card_deck << Card.new(suit, value)
#       end
#     end
#     Deck.new(card_deck)
#   end
#
# end
