def range(starting, ending)
  if ending <= starting
    return []
  else
    range(starting += 1, ending) << starting
  end
end

p range(0, 10) #=> [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

# ----------------------------------------------------------------------

def exponentiation(b, n)
  if n == 0
    return 1
  elsif n == 1
    return b
  elsif n.even?
    exponentiation(b, n / 2) ** 2
  elsif n.odd?
    b * (exponentiation(b, (n - 1) / 2) ** 2)
  end
end

p exponentiation(2, 3) #=> 8

# ----------------------------------------------------------------------

def fibonacci(n)
  if n == 0
    return []
  elsif n == 1
    return [0]
  elsif n == 2
    return [0, 1]
  else
    prev_num = fibonacci(n-2).last + fibonacci(n-1).last
    fibonacci(n-1) << prev_num
  end
end

p fibonacci(8) #=> [0, 1, 1, 2, 3, 5, 8, 13]

# ----------------------------------------------------------------------

def binary_search(arr, target)

  if arr.length == 0
    return nil
  end

  middle = arr.length / 2
  left = arr.take(middle)
  right = arr.drop(middle + 1)

  if arr[middle] == target
    return middle
  elsif target < arr[middle]
    binary_search(left, target)
  elsif target > arr[middle]
    sub_answer = binary_search(right, target)
    sub_answer.nil? ? nil : sub_answer + middle + 1
  end
end

p binary_search([1, 2, 3], 1) # => 0
p binary_search([2, 3, 4, 5], 3) # => 1
p binary_search([2, 4, 6, 8, 10], 6) # => 2
p binary_search([1, 3, 4, 5, 9], 5) # => 3
p binary_search([1, 2, 3, 4, 5, 6], 6) # => 5
p binary_search([1, 2, 3, 4, 5, 6], 0) # => nil
p binary_search([1, 2, 3, 4, 5, 7], 6) # => nil

# ----------------------------------------------------------------------

def merge_sort(arr)
  if arr.length < 2
    arr
  else
    middle = arr.length / 2
    left = arr.take(middle)
    right = arr.drop(middle)

    merge(merge_sort(left), merge_sort(right))
  end
end

def merge(left, right)
  sorted = []

  until left.empty? || right.empty?
    if left.first < right.first
      sorted << left.shift
    elsif right.first < left.first
      sorted << right.shift
    end
  end

  sorted + left + right
end

p merge_sort([4, 3, 6, 2]) #=> [2, 3, 4, 6]

# ----------------------------------------------------------------------

def subsets(arr)
  if arr.empty?
    return [[]]
  else
    last_num = arr[-1]
    smallerSubset = subsets(arr[0..-2])
    largerSubset = smallerSubset.map do |smallerArr|
      smallerArr + [last_num]
    end

    smallerSubset.concat(largerSubset)
  end
end

p subsets([]) # => [[]]
p subsets([1]) # => [[], [1]]
p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
