class Array

  def my_transpose
    result  = []
    (0...self.count).each do |row|
      array = []
      (0...self.count).each do |col|
        array << self[col][row]
      end
      result << array
    end
    result
  end
end
