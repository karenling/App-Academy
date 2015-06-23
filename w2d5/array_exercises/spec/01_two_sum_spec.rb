require 'rspec'
require '01_two_sum'

describe Array do

  describe "::two_sum" do
    subject { [-1, 0, 2, -2, 1] }
    it "should return pair of two sums" do
      expect(subject.two_sum).to contain_exactly([2, 3], [0,4])
    end

    it "should return ordered pair of two sums" do
      expect(subject.two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end
