class Array

  def two_sum
    positions =[]

    self.each_with_index do |n1, i1|
      self.each_with_index do |n2, i2|

        if 0-n2 == n1 && i1 != i2 && i1 < i2
          positions << [i1, i2]
        end

      end
    end

    positions
  end
end


p [-1, 0, 2, -2, 1].two_sum

# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]
# [[3, 2], [4, 0]]
