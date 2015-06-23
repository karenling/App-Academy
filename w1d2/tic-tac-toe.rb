class HumanPlayer

  attr_accessor :input

  def initialize

  end

  def input
    "Which position do you want?" #1, 2
    position = gets.chomp.split(",").map do |num|
      num.to_i
    end

  end

end

class ComputerPlayer
  attr_accessor :input

  def initialize
  end

  def input
    [rand(0..2), rand(0..2)]

  end

end


class Board

  attr_accessor :board, :pos

  def initialize
    @board = Array.new(3) {Array.new(3)}
  end

  def show
    @board.each do |row|
      p row
    end
  end

  def place_mark(pos, mark)

      @board[pos[0]][pos[1]] = mark if empty?(pos, mark)

  end


  def won?
    #8 options to win
    winning_options = [ [0,0, 0,1, 0,2],
                        [1,0, 1,1, 1,2],
                        [2,0, 2,1, 2,2],
                        [0,0, 1,0, 2,0],
                        [0,1, 1,1, 2,1],
                        [0,2, 1,2, 2,2],
                        [0,0, 1,1, 2,2],
                        [2,0, 1,1, 0,2]
                      ]
    winning_options.each do |possibility|
      if @board[possibility[0]][possibility[1]] == "X" &&
         @board[possibility[2]][possibility[3]] == "X" &&
         @board[possibility[4]][possibility[5]] == "X"
        p "You won!"
        return true
      elsif @board[possibility[0]][possibility[1]] == "O" &&
            @board[possibility[2]][possibility[3]] == "O" &&
            @board[possibility[4]][possibility[5]] == "O"
        p "You lost!"
        return true
      end


    end
    return false

  end

  def winner
  end

  def empty?(pos, mark) #checks if position is empty
    if @board[pos[0]][pos[1]].nil?
      true
    else
      if mark == "X"
        puts "Please choose an empty spot."
      end
      false
    end
  end
end



class Game
  attr_accessor :human
  def initialize
    @board = Board.new
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
  end

  def user_input
    puts "Which square do you want?"

  end

  def play

    until @board.won?

      user_input
      human_input = @human.input
      @board.pos = human_input
      @board.place_mark(@board.pos, "X")
      #@board.show

      computer_input = @computer.input
      @board.pos = computer_input
      @board.place_mark(@board.pos, "O")
      @board.show
    end
    # check move to be valid
    # check_won?
    #change players
  end


end

game = Game.new
game.play



#
# class ComputerPlayer
#
#   def initialize
#   end
#
#   def input
#     [rand(0..2), rand(0..2)]
#   end
#
# end
