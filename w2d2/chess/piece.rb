require "/Users/appacademy/Desktop/working/w2d2/chess/board.rb"

class Piece

  attr

  def initialize(color, pos, moved, board)
    @color = color
    @pos = pos
    @moved = moved
    @board = board
  end

#must have method 'moves' to work
  def valid_moves
    moves.reject do |index|
      other_piece = @board.grid[index.first][index.last]
      if other_piece.nil?
        false
      else
        other_piece.color == self.color
      end
    end
  end

  def explore(dir)
    y_diff = dir.first
    x_diff = dir.last
    list = []
    current = @pos.dup
    while current.all? { |ele| ele.between?(0,7) } && @board.grid[current.first][current.last].nil?
      list << current.dup
      current[0] += y_diff
      current[1] += x_diff
    end
    list
  end




end
