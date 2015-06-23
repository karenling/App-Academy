require 'byebug'

# @guess_counter => instance variable
# guess_counter => getter method (can be shadowed by local variables)
# self.guess_counter= => setter method

class GuessingGame
  attr_accessor :secret_number, :guess_counter, :guess

  def initialize
    @guess_counter = 0
    @secret_number = rand(1..100)
    @guess = nil
  end

  def prompt_user

    @guess_counter += 1
    puts "What is your guess?"
    @guess = gets.chomp.to_i
  end

  def check_number
    if @guess < @secret_number
      puts "Guess is too low."
    elsif @guess > @secret_number
      puts "Guess is too high."
    end
  end

  def win?
    if !@guess.nil? && @guess == @secret_number
      puts "You guessed correctly! The number was #{secret_number}."
      return true
    else
      false
    end

  end

  def play
    until win?
      prompt_user
      check_number
    end
  end
end

game1 = GuessingGame.new
game1.play
