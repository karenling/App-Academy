def stock_picker(stock_prices)
  max_profit = 0
  best_days = []
  stock_prices.each_with_index do |price, day|
    if stock_prices[day + 1].to_i - price > max_profit
      max_profit = stock_prices[day + 1].to_i - price
      best_days = [day, day + 1]
    end
  end
  best_days
end
