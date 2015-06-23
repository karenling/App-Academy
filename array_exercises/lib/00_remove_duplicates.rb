class Array
  def my_uniq
    arr = []
    self.each do |el|
    arr.include?(el) ? nil : arr << el
    # arr << el unless arr.include?(el
    end
    arr
  end
end
