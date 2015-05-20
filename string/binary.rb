def num_to_s(num, base)

  base_16 = { 10 => "A",
              11 => "B",
              12 => "C",
              13 => "D",
              14 => "E",
              15 => "F" }


  exponent = 0

  answer = []

  until base**exponent > num
    answer << num / base**exponent % base
    exponent += 1
  end

  answer.map! do |num|
    if num >= 10
      base_16[num]
    else
      num
    end
  end

  p answer.reverse.join
end

num_to_s(5, 10) #=> "5"
num_to_s(5, 2)  #=> "101"
num_to_s(5, 16) #=> "5"

num_to_s(234, 10) #=> "234"
num_to_s(234, 2)  #=> "11101010"
num_to_s(234, 16) #=> "EA"

234 / 1 % 16 #10
234 / 16 % 16 #14
