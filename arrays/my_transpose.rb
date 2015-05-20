def my_transpose(array)
  new_matrix = []

  length = array.length

  length.times do |i1|
    row = []

    length.times do |i2|
      row << array[i2][i1] #0, 0; 1, 0; 2, 0
    end

    new_matrix << row
  end

  new_matrix
end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
