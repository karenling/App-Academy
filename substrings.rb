def substrings(string)

  substring = []

  i = 0
  while i < string.length
    j = i
    while j < string.length
      unless substring.include?(string[i..j])
        substring << string[i..j]
      end
      j+=1
    end
    i+=1
  end

  subwords(substring)
end

def subwords(substrings)

  answer = []
  File.foreach("dictionary.txt") do |line|
    answer << line.chomp if substrings.include?(line.chomp)
  end

  answer
end

p substrings("cat")

#p substrings("philosophy")
