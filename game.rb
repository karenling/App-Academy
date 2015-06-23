require_relative 'checkers/board'

class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def won?
    black_pieces_left = @board.all_color_pieces(:black).count
    red_pieces_left = @board.all_color_pieces(:red).count

    if black_pieces_left == 0
      puts "Red wins!"
      return true
    elsif red_pieces_left == 0
      puts "Black wins!"
      return true
    end
  end

  def play
    puts "#{@player1.name}: Black".colorize(:yellow)
    puts "#{@player2.name}: Red".colorize(:yellow)

    @board.display_board

    # test a jump
    # @board.grid[0][0] = nil
    # @board.grid[1][1] = nil
    # @board.grid[2][2] = nil
    # @board.grid[2][0] = nil
    # @board.grid[1][5] = nil
    # @board.grid[1][7] = nil
    # @board.grid[2][4] = nil
    # @board.grid[2][6] = nil
    #
    # @board.grid[0][2] = nil
    # @board.grid[0][4] = nil
    # @board.grid[0][6] = nil
    # @board.add_piece(:black, [2, 4])

    # to do multiple moves
    # @board.display_board
    # @board.grid[2][2].perform_slide([3, 3])
    # @board.display_board
    # @board.grid[3][3].perform_moves!([4, 4])
    # @board.display_board
    # @board.grid[1][1] = nil
    # @board.display_board
    # @board.grid[1][3].perform_moves!([2, 2])
    # @board.display_board
    # # @board.grid[5][5].perform_moves!(*[[3, 3], [1, 1]])
    # # @board.display_board

    loop do
      prompt(@player1, :black)
      break if won?

      prompt(@player2, :red)
      break if won?
    end
  end

  def prompt(player, color)
    begin
      puts "\n#{player.name}, pick a #{color} piece. " +
            "i.e. \"[1, 1]\"".colorize(:color => :yellow)
      starting = gets.chomp
      starting = parse_answer(starting)
      starting = starting[0]

      puts ("#{player.name}, you have selected the #{color} piece at " +
            "#{starting}. Where would you like to move the piece? " +
            "Either enter a single coordinate or a list of " +
            "coordinates. i.e. \"[1, 1], [2, 2], [3, 3]\"").colorize(:yellow)

      moves = gets.chomp
      moves = parse_answer(moves)

      @board.grid[starting[0]][starting[1]].perform_moves!(*moves)
    rescue
      puts "Your move was invalid. Please pick again".colorize(:red)
    end

    @board.display_board
  end

  def parse_answer(list)
    list = list.delete("[")
    list = list.delete("]")
    list = list.split
    moves = []
    i = 0
    while i < list.length
    # list.each_with_index do |element, index|
      moves << [list[i].to_i, list[i+1].to_i]
      i += 2
    end
    moves
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

twinkie = HumanPlayer.new("Twinkie")
karen = HumanPlayer.new("Karen")

game = Game.new(twinkie, karen)

game.play
