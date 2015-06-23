require_relative 'board'

class Game

  attr_accessor :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1.color = :white
    @player2.color = :black

  end

  def play
    @board = Board.new
    @player1.board = @board
    @player2.board = @board

    turn = 0
    while true

      @board.display_board

      @player1.play_turn
      turn += 1
      break if @board.checkmate?(:black)

      @board.display_board

      @player2.play_turn
      turn += 1
      break if @board.checkmate?(:white)

    end


    @board.display_board


    winner = turn.odd? ? @player1.name : @player2.name
    puts "Congrats #{winner}, you won in #{turn/2} rounds!"

  end

end

class HumanPlayer
  attr_accessor :color, :board, :name

  def initialize(name)
    @name = name
  end

  def parse_answer(pick_position)
    x_position = pick_position[0].ord - 65

    y_position = 8 - pick_position[1].to_i
    [y_position, x_position]
  end



  def play_turn
    begin
      puts "#{@name}, please enter the coordinate of a piece you would like to move? i.e. A1"
      pick_position = gets.chomp
      starting_position = parse_answer(pick_position)

      puts "#{@name}, please enter the coordinate you would like to move your piece to? i.e. B2"
      pick_position = gets.chomp
      ending_position = parse_answer(pick_position)

      @board.move(starting_position, ending_position)
    # valid_ending = @board.pieces(color).any? { |piece| piece.pos == starting_position }
    rescue
      puts "Retry with a valid move."
      retry
    end


  end

end

daniel = HumanPlayer.new("Player1")
karen = HumanPlayer.new("Player2")

chess = Game.new(daniel, karen)
chess.play
