require 'rspec'
require '04_stock_picker'

describe "#stock_picker" do
  subject(:stock_prices) { [-4, 3, 2, 5, -10, 6]}
  it "should return pair of most profitable days" do
    expect(stock_picker(stock_prices)).to eq([4, 5])
  end

end
