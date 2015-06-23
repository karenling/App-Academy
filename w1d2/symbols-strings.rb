require 'byebug'

def super_print(word, options = {})
  default = {
    upcase: false,
    reverse: false,
    times: 1
  }

  final = default.merge(options)

  word = word * final[:times]
  word = word.upcase if final[:upcase]
  word = word.reverse if final[:reverse]

=begin
  if final[:upcase]
    word = word.upcase
  end

  if final[:reverse]
    word = word.reverse
  end

=end
  #word

  # (final[:times]).times do
  #   puts word
  # end
  # p word = word * final[:times]
  # nil
end

p super_print("Hello")                                    #=> "Hello"
p super_print("Hello", :times => 3)                       #=> "Hello" 3x
p super_print("Hello", :times => 3, :upcase => true)                   #=> "HELLO"
p super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

 options = {}
 super_print("hello", options)
