class Array
  def my_uniq
    unique_numbers = []

    self.each do |element|
      unique_numbers << element if !unique_numbers.include?(element)
    end

    unique_numbers
  end

  def two_sum
    pair_positions = []

    self.each_with_index do |num1, index1|
      self.each_with_index do |num2, index2|
        if num1 + num2 == 0 && index1 < index2
          pair_positions << [index1, index2]
        end
      end
    end

    pair_positions
  end
end

def my_transpose(array)
  transposed = []

  array.each_with_index do |element1, index1|
    row = []
    array.each_with_index do |element2, index2|
      row << array[index2][index1]
    end
    transposed << row
  end

  transposed
end

def stock_picker(array)
  largest_price = buy_price
  array.each do |buy_price, buy_day|
    array.each do |sell_price, sell_day|

    end
  end
end
