require "/Users/appacademy/Desktop/working/w2d2/chess/piece.rb"

class SteppingPiece < Piece

  attr_reader :deltas
  def initialize(color, pos, moved, board, type)
    super(color, pos, moved, board)
    @type = type
  end


  def moves
    case @type
    when :knight
      list = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    when :king
      list = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    end
    list
  end

end

board = Board.new
knight = SteppingPiece.new(:black, [0, 0], false, board, :knight)
p knight.valid_moves

#   + #move_diffs()
  #  + King
  #  + Knight
