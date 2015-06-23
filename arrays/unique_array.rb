class Array
  def my_uniq
    uniq_numbers = []
    self.each do |ele|
      if !uniq_numbers.include? ele
        uniq_numbers << ele
      end
    end

    uniq_numbers
  end
end


p [1, 2, 1, 3, 3].my_uniq
