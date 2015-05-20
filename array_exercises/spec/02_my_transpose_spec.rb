require 'rspec'
require '02_my_transpose'

describe Array do
  describe "::my_transpose" do
    let(:self_array) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8] ] }
    let(:other_array) { [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]] }

    it "should convert from a row to column orientated matrix" do
      expect(self_array.my_transpose).to eq(other_array)
    end
  end
end
