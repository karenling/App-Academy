require 'rspec'
require 'hand'


describe Hand do
  describe "poker hands" do
    let(:hand) { Hand.new([Card.new(:clubs, :queen), Card.new(:hearts, :queen),
                  Card.new(:diamonds, :queen), Card.new(:spades, :queen),
                  Card.new(:diamonds, :five)]) }


    context "when player has straight flush" do
    end

    context "when player has four of a kind" do
      it "should have 4 cards of the same value" do
        expect(hand.four_of_a_kind?).to eq(:queen)
      end

    end

    context "when player has full house" do
    end
    context "when player has flush" do
    end
    context "when player has straight" do
    end
    context "when player has three of a kind" do
    end
    context "when player has two pair" do
    end
    context "when player has one pair" do
    end
    context "when player has high card" do
    end

  end

end
