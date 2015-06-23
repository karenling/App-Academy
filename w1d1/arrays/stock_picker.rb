def stock_picker(arr)
  profit = arr[1] - arr[0]
  dates = []

  arr.each_with_index do |buy_price, buy_date|

    arr.each_with_index do |sell_price, sell_date|
      if sell_price - buy_price > profit && buy_date < sell_date
        profit = sell_price - buy_price
        dates = [buy_date, sell_date]
      end
    end

  end

  dates
end

p stock_picker([3, 0, 5, 9, 4])
