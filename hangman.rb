require 'byebug'
class Hangman
  def initialize(guessing_player, checking_player)
    @guesser = guessing_player
    @checker = checking_player
  end

  def display
     puts "Secret word: " + @checker.working_word.join("")
  end

  def guess
    @guesser.ask_guess
  end

  def check(guess)
    guess_is_true = @checker.update_working_word(guess)
    position = @checker.positions
    @guesser.get_only_matching_length_and_position_words(guess, position, guess_is_true)#pass the guess and the positions to the guesser

  end



  def play
    @checker.make_word
    @guesser.intelligent_guesses(@checker.secret_word.length)
    display


    until won?
      check(guess)
      display
    end

    puts @guesser.winning_announcement
  end

  def won?
    @checker.win?
  end
end

class HumanPlayer

  attr_reader :secret_word, :working_word, :positions

  def make_word
    puts "How long is your word?"
    word_length = Integer(gets.chomp)
    @secret_word = "*" * word_length
    @working_word = Array.new(@secret_word.length) { "_" }
    # debugger
  end

  def win?
    #debugger
    return @working_word.include?('_') ? false : true #thi sis allowing the computer guesser to win
  end


  def valid_positions(pos)
    # valid = false
    # pos.all? do |position|
    #   position.to_i.between?(0, @secret_word.length - 1)
    # end
    valid = false
    pos.each do |position|
      valid = true
      valid = false if !position.to_i.between?(0, @secret_word.length - 1)
    end
    valid == false ? puts("Please enter valid positions.") : (return true)
  end

  def update_working_word(guess)
    response = gets.chomp.upcase

    if response == "Y"
      puts "\nWhere's the letter located? [X Y]"
      pos = nil
      loop do
        pos = gets.chomp.split(' ')
        break if valid_positions(pos)
      end

      pos.each do |position|
        @working_word[position.to_i] = guess
      end

      #if the first letter guess is correct
      #then we need to narrow down the dictionary with
      #only words that are same length and
      #has the letter at the given position(s)
      @positions = pos
    end
  end

  def intelligent_guesses(num)
  end


  #used when a guesser

  def winning_announcement
    puts "You won!"
  end
  def ask_guess
    guess = gets.chomp.downcase
    check_guess_is_valid?(guess) ? guess : ask_guess
  end

  def check_guess_is_valid?(guess)
    letters = ("a".."z").to_a
    letters.include?(guess) ? true : puts("That's not a letter.\n\n")
  end

  def checker_gives_positions_to_guesser(positions)
  end

  def get_only_matching_length_and_position_words(letter, positions, guess_is_true)
  end
end

class ComputerPlayer
  attr_reader :secret_word, :word_options, :positions, :working_word

  def initialize
    @word_options = File.readlines('dictionary.txt')
    @letters = ("a".."z").to_a
  end

  # used when a checker
  def make_word
    @secret_word = File.readlines('dictionary.txt').sample.chomp.downcase.split('')
    @working_word = Array.new(@secret_word.length) { "_" }
  end

  def update_working_word(guess)
    # pos = []
    # @secret_word.each_with_index do |letter, i|
    #   pos << i if @secret_word[i] == letter
    # end
    pos = @secret_word.length.times.select { |letter| @secret_word[letter] == guess }
    pos.each do |position|
      @working_word[position] = guess
    end


  end

  def win?
    @working_word.join("") == @secret_word.join("")
  end



  #used when a guesser





  def intelligent_guesses(num)
    @length = num
    @word_options.map! do |word|
      word.gsub("\n", "")
    end

    @word_options = @word_options.select do |word|
      word.length == num
    end
    most_common_letters = {}
    @word_options.join("").split("\n").join("").each_char do |letter|
      if most_common_letters.has_key?(letter)
        most_common_letters[letter] += 1
      else
        most_common_letters[letter] = 1
      end
    end

    @most_common_letters = most_common_letters
    #p @word_options

  end


  def get_only_matching_length_and_position_words(letter, positions, guess_is_true)
    if guess_is_true
      # p @word_options
      # puts "are you here?"
      # puts "POSTIIONS ARE #{@positions}"
      # p @word_options
      all_positions = (0...@length).to_a
      positions.each do |position|
        #p "position is: " + position.to_s
        all_positions.delete(position)
        @word_options.select! do |words|
            words[position.to_i] == letter
        end
      end
      # @word_options.select do |word|
      #   positions.each do |position|
      #     word[position] == letter
      #   end
      # end




      p @word_options


      puts "THIS IS RUNNING"
      p @word_options
    else #if thie letter guessed is false, we want to remove it from our dictionary
      #and from our most_common_letters
      p @most_common_letters.delete(letter)
      @word_options.select! do |word|
        !word.include?(letter)
      end
      p @word_options
    end

    #if the first letter guess is correct
    #then we need to narrow down the dictionary with
    #only words that are same length and
    #has the letter at the given position(s)

  end


  def winning_announcement
    puts "I won!"
  end

  def ask_guess
    max = @most_common_letters.values.max
    guess = @most_common_letters.key(max)
    @most_common_letters.delete(guess)
    puts "Is there a(n) #{guess}? Y/N"
    return guess

    # guess = @letters.sample
    # @letters.delete(guess)
    # puts "Is there an #{guess}? [Y/N]?"
    # return guess
  end
end


  comp = ComputerPlayer.new
  human = HumanPlayer.new
  # guesser, checker
  #  h = Hangman.new(human, comp)
  h = Hangman.new(comp, human)
  h.play
