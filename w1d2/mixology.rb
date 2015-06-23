def remix(arr)

  original_arr = arr

  mixers = []

  arr.each_with_index do | pair, idx |
    mixers << arr[idx].pop
  end

  mixers.shuffle!

  arr.each_with_index do | alcohol, idx |
    arr[idx] << mixers.pop
  end

  until unique_remix?(original_arr, arr)
    remix(original_arr)
  end

end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
#=> [["rum, "tonic"], ["gin", "soda"], ["scotch", "coke"]]

def unique_remix?(original_arr, remixed_arr)
end

=begin
# Try to solve the bonus problem later

def guaranteed_remix(drinks)
  remix_attempt = remix(drinks)
  until totally_new_drinks?(remix_attempt, drinks)
    remix_attempt = remix(drinks)
  end
end

def totally_new_drinks?(drinks1, drinks2)
  drinks1.none? { |drink1| drinks2.include?(drink1) }
end

[[gin, coke], [rum, soda], [vodka, lemonade]]         [[gin, coke], [vodka, soda], [rum, lemonade]]

=end
