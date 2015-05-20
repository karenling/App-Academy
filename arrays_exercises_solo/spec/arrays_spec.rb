require 'rspec'
require 'arrays'


# describe Array do
#   let(:array) { [1, 2, 1, 3, 3] }
#   it "array should be returned unique elements" do
#     expect(array.my_uniq). to eq([1, 2, 3])
#   end
# end

describe "Array exercises" do
  describe "::my_uniq" do
    context "when valid array" do
      let(:array) { [1, 2, 1, 3, 3] }
      it "array should be returned unique elements" do
        expect(array.my_uniq).to eq([1, 2, 3])
      end
      it "empty array" do
        expect([].my_uniq).to eq([])
      end
    end

    context "when invalid arrays" do
      let(:invalid_array) { "hello" }
      it "should raise an error" do
        expect { invalid_array.my_uniq }.to raise_error
      end
    end


  end

  describe "::two_sum" do
    context "when valid array" do
      let(:array) { [-1, 0, 2, -2, 1] }
      it "returns all pairs of positions where they sum to zero" do
        expect(array.two_sum).to eq([[0, 4], [2, 3]])
      end
      it "empty array" do
        expect([].two_sum).to eq([])
      end
    end

    context "when invalid arrays" do
      let(:invalid_array) { "hello" }
      it "should raise an error" do
        expect { invalid_array.two_num }.to raise_error
      end
    end
  end

  describe "#my_transpose" do
    context "when valid array" do
      let(:rows) { [[0, 1, 2], [3, 4, 5],  [6, 7, 8]] }
      it "returns transposed array" do
        expect(my_transpose(rows)).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
      end
      it "empty array" do
        expect(my_transpose([])).to eq([])
      end
    end

    context "when invalid arrays" do
      let(:invalid_array) { "hello" }
      it "should raise an error" do
        expect { my_transpose(invalid_array) }.to raise_error
      end
    end
  end

  describe "#stock_picker" do
    context "when vaild array" do
      let(:array) { [1, 9, 3, 8, 2] }
      it "returns most profitable pairs of days" do
        expect(stock_picker(array)).to eq([0, 1])
        expect(stock_picker(array)).to_not eq([2, 3])
      end

      it "returns empty array when passed empty array" do
        expect(stock_picker([])).to eq([])
      end

    end
  end
end
