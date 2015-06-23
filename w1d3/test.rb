class Hangman
  attr_reader :secret_word


  def display
     puts "Secret word: " + @working_word.join("")
  end

  # def update_working_word(guess)
  #   @secret_word.each_with_index do |letter, idx|
  #     @working_word[idx] = letter if letter == guess
  #   end
  # end

  def update_working_word(guess)
      pos = @secret_word.length.times.select{ |letter| @secret_word[letter] == guess}
      pos.each do |position|
        @working_word[position] = guess
      end
      "working word : " + @working_word.to_s
  end

  def check_guess_is_valid?(guess)
    letters = ("a".."z").to_a
    letters.include?(guess) ? true : puts("That's not a letter.\n\n")
  end

  def ask_guess
    guess = gets.chomp.downcase
    check_guess_is_valid?(guess) ? guess : ask_guess
  end

  def get_secret_word
    #get word from HumanPlayer
    word = ComputerPlayer.new.make_word#"hello".split('')

    @secret_word = word
    @working_word = Array.new(@secret_word.length) { "_"}
  end


  def play
    get_secret_word
    display
    until won
      update_working_word(guess)
      display
    end
  end

  def won
    if @secret_word == @working_word
      puts "You won!"
      true
    else
      false
    end
  end

end
#
# class HumanPlayer
#   def make_word
#     @word =
#   end
# end


class ComputerPlayer
  attr_reader :word
  def initialize
    @game = Hangman.new
  end


  def make_word

    @word = File.readlines('dictionary.txt').sample.chomp.downcase.split('')
  end


end

c = ComputerPlayer.new
# test = Hangman.new
# # p player = ComputerPlayer.new.make_word
# h = Hangman.new
# # # h.get_secret_word
# h.play
# # h.won
# p h.get_secret_word

# h = "hello".split('')
# p h.length.times.select{ |letter| h[letter] == 'l'}
