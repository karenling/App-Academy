require 'rspec'
require 'deck'


describe Deck do
  subject(:deck) { Deck.new }

  let(:clubs) { deck.card_deck.select { |card| card.suit == :clubs } }
  let(:hearts) { deck.card_deck.select { |card| card.suit == :hearts } }
  let(:spades) { deck.card_deck.select { |card| card.suit == :spades } }
  let(:diamonds) { deck.card_deck.select { |card| card.suit == :diamonds } }


  describe "suits" do
    it "card count" do
      expect(deck.card_deck.count).to eq(52)
      expect(clubs.count).to eq(13)
      expect(hearts.count).to eq(13)
      expect(spades.count).to eq(13)
      expect(diamonds.count).to eq(13)
    end
    it "should have unique values per suit" do
      clubs_holder = []
      clubs.each { |card| clubs_holder << card.value }
      expect(clubs_holder.uniq).to eq(clubs_holder)

      hearts_holder = []
      hearts.each { |card| hearts_holder << card.value }
      expect(hearts_holder.uniq).to eq(hearts_holder)

      spades_holder = []
      spades.each { |card| spades_holder << card.value }
      expect(spades_holder.uniq).to eq(spades_holder)

      diamonds_holder = []
      diamonds.each { |card| diamonds_holder << card.value }
      expect(diamonds_holder.uniq).to eq(diamonds_holder)
    end
  end
end
