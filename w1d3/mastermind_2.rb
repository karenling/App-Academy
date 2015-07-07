class CodeSequence
  attr_reader :code, :matches

  def initialize(code_sequence)
    @code = code_sequence
    @matches = Array.new(4, nil)
  end

  def self.random
    CodeSequence.new(%w(G G G G))
    #CodeSequence.new(%w(R G B Y O P).shuffle![0..3])
  end

  def self.parse(user_input)
    CodeSequence.new(user_input.split(''))
  end

  def exact_matches(user_guess) #right color in right spot (black)
    user_code = user_guess.code
    right_color_right_spot = 0
    user_code.each_with_index do |guess_color, guess_position|
      @code.each_with_index do |secret_color, secret_position|
        if guess_color == secret_color && guess_position == secret_position
          right_color_right_spot += 1
        end
      end
    end
    right_color_right_spot
  end

  def near_matches(user_guess) #right color, wrong spot (white)
    user_code = user_guess.code
    right_color_counter = 0
    unique_colors = @code.dup # G B G Y
    user_code.each do |color|
      if unique_colors.include?(color)
        right_color_counter += 1
        color_index = unique_colors.index(color)
        unique_colors.delete_at(color_index)
      end
    end
    right_color_counter
  end


  def clear_pegs
    @matches = Array.new(4, nil)
  end
end

class Game
  def initialize
    @secret_code = CodeSequence.random
  end

  def ask_user
    puts "Choose four colors from R G B Y O P"
    user_input = gets.chomp
    user_guess = CodeSequence.parse(user_input)
  end

  def present_pegs(exact_number, near_number)
    exact_number.times do |idx|
      @secret_code.matches[idx] = "B"
    end
    near_number.times do |idx|
      if @secret_code.matches[idx].nil?
        @secret_code.matches[idx] = "W"
      end
    end

    p @secret_code.matches
  end

  def results(user_guess)
    exact_count = @secret_code.exact_matches(user_guess)
    near_count = @secret_code.near_matches(user_guess)
    present_pegs(exact_count, near_count)
    @secret_code.clear_pegs
  end

  def play
    10.times do |turn|
      user_guess = ask_user
      results(user_guess)
      break if won?(user_guess)
      puts "\n You are on turn \##{turn + 1}. \n\n"

    end
    puts "Game Over"
  end

  def won?(user_guess)
    if @secret_code.exact_matches(user_guess) == 4
      puts "You won!"
      true
    end
  end
end

g = Game.new
g.play
