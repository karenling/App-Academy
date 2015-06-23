def concatenate(arr)
  arr.inject("") do |total, word|
    total << word << " "
  end
end


p concatenate(["the", "bear", "is", "hungry"])
p concatenate(["Yay", "for", "strings!"])
# => "Yay for strings!"
