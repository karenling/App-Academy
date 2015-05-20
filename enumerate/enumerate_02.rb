def median(arr)

  length = arr.count
  if length % 2 != 0 #odd
    return arr.sort[length/2]
  else #even
    return (arr.sort[length/2] + arr.sort[length/2-1])/2.0
  end

end


p median([1, 2, 3]) # 2
p median([1, 2, 3, 4]) # 2.5
