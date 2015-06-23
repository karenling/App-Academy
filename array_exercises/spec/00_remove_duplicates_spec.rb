require 'rspec'
require '00_remove_duplicates'

describe Array do
  subject { [1,2,1,3,3] }
  describe "::my_uniq" do
    it " should remove duplicate elements" do
      expect(subject.my_uniq).to eq([1,2,3])
    end
  end

end
