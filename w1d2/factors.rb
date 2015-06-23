# Write a method factors that prints out all the factors of a given number.

def factors(num)
  answers = []

  num.times do |i|
    i+=1
    if num%i == 0
      answers << i
    end
  end

  answers
end


p factors(4)
p factors(9)
p factors(19)
