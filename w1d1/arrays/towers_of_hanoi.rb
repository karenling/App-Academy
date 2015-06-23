
class TowersOfHanoiGame

  attr_accessor :pile_1, :pile_2, :pile_3

  def initialize(arr1 = [], arr2 = [], arr3 = [])
    @pile_1 = arr1
    @pile_2 = arr2
    @pile_3 = arr3
  end

=begin
  def pile_1(pile_1)
    @pile_1
  end
=end
  def ask #ask the player for pile
    answer = gets.chomp

    answers = ["1", "2", "3"]
    until answers.include?(answer)
      puts "Please select from 1, 2, or 3"
      answer = gets.chomp
    end

    if answer == "1"
      answer = @pile_1
    elsif answer == "2"
      answer = @pile_2
    elsif answer == "3"
      answer = @pile_3
    end

    return answer
  end


  def game

    p @pile_1
    p @pile_2
    p @pile_3
    length = @pile_1.length + @pile_2.length + @pile_3.length

    puts "Well to the Towers of Hanoi Game!"

    from_pile = ""
    to_pile = ""
    until @pile_2.length == length || @pile_3.length == length



      puts "Which pile would you like to pick from? 1, 2, 3?"
      from_pile = ask

      if from_pile.empty?
        puts "You can't pick from an empty pile."
        from_pile = ask

      end

      puts "Which pile would you like to place the disc on? pile_1, pile_2, or pile_3?"
      to_pile = ask

      while !to_pile.empty? && from_pile.last > to_pile.last
        puts "You cannot place a larger disc on top of a smaller disc. Please select a different pile you would like the place the disc on."
        to_pile = ask

      end

      to_pile << from_pile.pop

      p "pile_1 is #{@pile_1}"
      p "pile_2 is #{@pile_2}"
      p "pile_3 is #{@pile_3}"


    end

    puts "You have won!"

  end

end

p TowersOfHanoiGame.new([5, 4, 3, 2, 1], [], []).game
