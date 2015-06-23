def bubble_sort(arr)
  i = 0
  while i < arr.length
    j = i+1
    while j < arr.length
      if arr[i] > arr[j]
        arr[i], arr[j] = arr[j], arr[i]
      end
      j+=1
    end
    i+=1
  end

  arr
end

p bubble_sort([4, 3, 5, 2, 1]) #1, 2, 3, 4, 5
p bubble_sort([10, 9, 8, 7, 6, 4, 3, 5, 2, 1])

            
p bubble_sort([9, 8, 7, 6, 4, 3, 5, 2, 1, 10])
