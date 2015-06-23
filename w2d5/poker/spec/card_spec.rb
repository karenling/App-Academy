require 'rspec'
require 'card'

describe Card do
  describe "check suit and values" do
    context "when card is incorrectly initialized" do
      it "should raise error for wrong suits" do
        expect{ Card.new(:coffee, :deuce) }.to raise_error
      end

      it "should raise error for wrong values" do
        expect{ Card.new(:hearts, :coffee ) }.to raise_error
      end
    end
    context "when card is properly initialized" do
      it "should not raise error for correct values and suits" do
        expect{ Card.new(:hearts, :deuce) }.to_not raise_error
      end
    end
  end
end
