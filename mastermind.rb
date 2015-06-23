# class Code
#   PEGS = %w(R G Y O P)
#
#   def initialize
#     @code = 'RGYR'
#   end
# end

class Mastermind
  attr_reader :correct_combo, :pegs, :guess, :turn

  def initialize
    @pegs =  %w(R G B Y O P)
    @correct_combo = randomize_pegs
    @turn = 0
    @guess = []
  end

  def randomize_pegs
    [].tap do |array|
      4.times do
        array << @pegs.sample
      end
    end
  end

  def ask_guess
    puts "---------------"
    puts "What's your guess?"
    puts "This is turn: #{@turn}"




    begin
      @guess = gets.chomp.split("")
      unless valid_guess?
        raise ArgumentError.new "That's not a valid guess."
      end
    rescue ArgumentError => e
      puts "Error was: #{e.message}."
      puts "Enter another guess"
      # @guess = gets.chomp.split("")
      retry
    end


    # until valid_guess?
    #   puts "Invalid guess, Try again!"
    #   @guess = gets.chomp.split("")
    # end
  end

  def valid_guess?
    @guess.all? { |peg| @pegs.include?(peg) } && @guess.count == 4
  end

  def end_game?
    won? || turn_ten?
  end

  def turn_ten?
    @turn == 10
  end

  def won?
    guess == @correct_combo
  end

  def exact_matches
    @matches = []
    match_count = 0
    @guess.each_with_index do |peg, index|
      if peg == @correct_combo[index]
        match_count += 1
        @matches << index
      end
    end
    puts "You have #{match_count} exact matches"
  end

  def near_matches
    near_matches = 0
    temp_guess = []

    @guess.each_with_index do |x, index|
      temp_guess << x unless @matches.include?(index)
    end

    temp_correct = []
    @correct_combo.each_with_index do |x, index|
      temp_correct << x unless @matches.include?(index)
    end

    temp_guess.each do |peg|
      if temp_correct.include?(peg)
        near_matches += 1
        temp_correct.delete(peg)
      end
    end
    puts "You have #{near_matches} near matches"
  end

  def run
    until end_game?
      @turn += 1
      ask_guess
      exact_matches
      near_matches
    end
    if won?
      p "YOU WIN!"
    elsif turn_ten?
      p "YOU LOSE!"
    end
  end
end

game = Mastermind.new
game.run
