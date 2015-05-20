#require 'byebug'

class RPN

  def initialize(token = [])
    @input = token #"5 1 2 + 4 * + 3 -"

    @input = convert_to_array(token) if token.is_a?(String)

    @answer = []
  end

  def convert_to_array(string)
    operators = %w(+ - * /)
    string = string.split(" ").map do |element|
      if operators.include?(element)
        element
      else
        Integer(element)
      end
    end
    return string
  end

  def show_input
    @input
  end

  def add
    @answer << @answer.pop + @answer.pop
  end

  def minus
    @answer << -@answer.pop + @answer.pop
  end

  def multiply
    @answer << @answer.pop * @answer.pop
  end

  def divide
    @answer << 1/@answer.pop * @answer.pop
  end

  def add_to_answer_array(element)
    p @answer << element
  end

  def answer_value
    @answer[0]
  end

  def evaluate
    @input.each do |element|
      case element
      when "+"
        add
      when "-"
        minus
      when "*"
        multiply
      when "/"
        divide
      else
        add_to_answer_array(element)
      end
    end

    answer_value
  end

  def ask_user
    @input = []
    puts "What would you like me to calculate?"
    loop do
      user_input = gets.chomp
      break if user_input == "="
      @input << user_input
    end

    @input = convert_to_array(@input.join(" "))

    evaluate

  end
end

# #confirm that RPN calculator works with string directly
# testing = RPN.new("5 1 2 + 4 * + 3 -")
# p testing.show_input
# p testing.evaluate

# confirm that RPN calculator works with user input
asking = RPN.new
p asking.ask_user

# # confirm that RPNA calculator can use a ARGV
# input = File.read(ARGV[0])
# argument = RPN.new(input)
# p argument.evaluate














# filename = ARGV[0]
#
# input = File.read(filename)
# script_testing = RPN.new(input)
# p script_testing.parse
#
#
#
# stdin_testing = RPN.new("5 1 2 + 4 * + 3 -")
# p stdin_testing.parse



# class
# use a stack to hold the operations
# use a stack to hold the numbers
# every two numbers we pop the operation stack and perform it on the two numbers
# continue until done

# user interface
# You should be able to invoke it as a script from the command line.
# You should be able to, optionally, give it a filename on the command line,
# in which case it opens and reads that file instead of reading user input.



# 5 1 2 + 4 * + 3 -  = equation
# 5 3 4 * + 3 -
# 5 12 + 3 -
# 17 3 -
# 14
#
#
#
#
# equation_new << equation.pop until equation.pop
#
# [5, 1, 2]    [+ 4 * + 3 -]
# [5] << [1+2]
