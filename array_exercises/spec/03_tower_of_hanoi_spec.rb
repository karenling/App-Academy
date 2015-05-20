require 'rspec'
require '03_towers_of_hanoi'


describe "Towers of Hanoi" do
  subject(:towers) { [[3, 2, 1], [], []] }
  subject(:towers_2) { [[1], [2], [3]] }

  describe "#move" do
    context "tower move from is not empty" do
      it "returns nil if choosing from empty tower" do
        expect {move(towers, 2, 1)}.to raise_error
      end
      it "raises error if choosing from non-existant tower" do
        expect {move(towers, 3, 1) } .to raise_error
      end
    end

    context "asking for user input" do
      it "accept valid input" do
        expect {move(towers, 0, 1)}.to_not raise_error
      end
      it "does not accept invalid input" do
        expect { move(towers, 0, "1")}.to raise_error
      end
    end

    context "last disc at ending tower is larger than current disc" do
      it "raises error" do
        expect { move([[1], [2], [3]], 2, 0) }.to raise_error
      end
    end

    context "valid moves" do
      it "should move from and to valid tower" do
        expect { move(towers, 0, 2)}.to_not raise_error
      end
    end
  end

  describe "#create_towers" do
    context "when accepting number of discs" do
      it "should raise an error if not an integer" do
        expect { create_towers("3") }.to raise_error
      end

      it "should accept an integer" do
        expect(create_towers(3)).to eq(towers)
      end
    end
  end

  describe "#won?" do
    it "Should return true if won" do
      expect(won?([[], [3, 2, 1], []], 3)).to be true
    end
    it "should return false if not won" do
      expect(won?([[3], [2,1], []], 3)).to be false
    end
  end

end

# let(:bad_user_input) { towers, 0, "1" }
# let(:valid_user_input) { (towers, 0, 1) }
