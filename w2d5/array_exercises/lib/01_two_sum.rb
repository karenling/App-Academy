class Array

  def two_sum
    arr = []
    (0...self.count).each do |start|
      (start...self.count).each do |stop|
        if self[start] + self[stop] == 0
          if self[start] != 0
            arr << [start, stop] if self[start] + self[stop] == 0
          end
        end
      end
    end
    arr
  end
end
