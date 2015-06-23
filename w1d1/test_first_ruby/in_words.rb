# https://github.com/appacademy/test-first-ruby/blob/master/spec/15_in_words_spec.rb

class Fixnum

  def each_hundred(working)

    ones = {  0 => "zero", 1 => "one", 2 => "two", 3 => "three",  4 => "four",
            5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine"
          }


    teens = { 10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen",
              14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
              18 => "eighteen", 19 => "nineteen"
            }


    tens =  { 20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty",
              60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"
              }

    bigs = [ "hundred", "thousand", "million", "billion", "trillion"]


    #puts "our working number is: #{working}"

    answer_holder = []

    #print "this is the hundredths place: " #432/100 = 4 (four hundred)
    hundredth =  working/100

    #print "this is the teens: "
    teenth = working%100

    #print "this is the tenths place: " #432/10 =43
    tenths = working%100 - working%10

    #print "this is the digit place: "
    digit = working%10


    answer_holder << ones[hundredth] << "hundred" if hundredth != 0

    if teenth < 20 && teenth >= 10
      answer_holder << teens[teenth]
    else
      answer_holder << tens[tenths] if tenths  != 0
      answer_holder << ones[digit] if digit != 0
    end

    return answer_holder
  end

  def in_words

      return "zero" if self == 0

      number = self ##123_456_789_123_456
      answer = []


      if number >= 1_000_000_000_000 #123_456_789_123_456
        working = number/1_000_000_000_000 #123
        answer << each_hundred(working)
        answer << "trillion"
      end

      number = number%1_000_000_000_000 #456_789_123_456
      if number >= 1_000_000_000
        working = number/1_000_000_000 #456
        answer << each_hundred(working)
        answer << "billion"
      end

      number = number%1_000_000_000 #456_789_123_456 % 1_000_000_000 = 789_123_456
      if number >= 1_000_000
        working = number/1_000_000 #789
        answer << each_hundred(working)
        answer << "million"
      end


      number = number%1_000_000 #789_123_456 % 1_000_000 = 123_456
      if number >= 1000
        working = number/1000 # 123_456 / 1000 = 123
        answer << each_hundred(working)
        answer << "thousand"
      end

      number = number%1000 #123_456 % 1000 = 456
      if number >= 100
        working = number # 456
        answer << each_hundred(working)

      end


      if number < 100 # 11..99

        working = number
        answer << each_hundred(working)
      end

      #p answer
      #p answer.join(" ").split(" ").join(" ")
      return answer.join(" ").split(" ").join(" ")


  end

end



p 0.in_words == 'zero'
p 1.in_words == 'one'
p 2.in_words == 'two'
p 3.in_words == 'three'
p 4.in_words == 'four'
p 5.in_words == 'five'
p 6.in_words == 'six'
p 7.in_words == 'seven'
p 8.in_words == 'eight'
p 9.in_words == 'nine'
p 10.in_words == 'ten'


p 11.in_words == 'eleven'
p 12.in_words == 'twelve'


p 13.in_words == 'thirteen'
p 14.in_words == 'fourteen'
p 15.in_words == 'fifteen'
p 16.in_words == 'sixteen'
p 17.in_words == 'seventeen'
p 18.in_words == 'eighteen'
p 19.in_words == 'nineteen'


p 20.in_words == 'twenty'
p 30.in_words == 'thirty'
p 40.in_words == 'forty'
p 50.in_words == 'fifty'
p 60.in_words == 'sixty'
p 70.in_words == 'seventy'
p 80.in_words == 'eighty'
p 90.in_words == 'ninety'


p 20.in_words == 'twenty'
p 77.in_words == 'seventy seven'
p 99.in_words == 'ninety nine'


p 100.in_words == 'one hundred'
p 200.in_words == 'two hundred'
p 300.in_words == 'three hundred'
p 123.in_words == 'one hundred twenty three'
p 777.in_words == 'seven hundred seventy seven'
p 818.in_words == 'eight hundred eighteen'
p 512.in_words == 'five hundred twelve'
p 999.in_words == 'nine hundred ninety nine'


p 1000.in_words == 'one thousand'
p 32767.in_words == 'thirty two thousand seven hundred sixty seven'

p 32768.in_words == 'thirty two thousand seven hundred sixty eight'



p 10_000_001.in_words == 'ten million one'


p 1_234_567_890.in_words == 'one billion two hundred thirty four million five hundred sixty seven thousand eight hundred ninety'


p 1_000_000_000_000.in_words == 'one trillion'
p 1_000_000_000_001.in_words == 'one trillion one'
p 1_888_259_040_036.in_words == 'one trillion eight hundred eighty eight billion two hundred fifty nine million forty thousand thirty six'
