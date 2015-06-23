require_relative "piece.rb"

# require "/Users/appacademy/Desktop/working/w2d2/chess/board.rb"
# # require "/Users/appacademy/Desktop/working/w2d2/chess/game.rb"
# # require "/Users/appacademy/Desktop/working/w2d2/chess/pawn.rb"
# require "/Users/appacademy/Desktop/working/w2d2/chess/piece.rb"
# # require "/Users/appacademy/Desktop/working/w2d2/chess/player.rb"
# # require "/Users/appacademy/Desktop/working/w2d2/chess/sliding_piece.rb"
# # require "/Users/appacademy/Desktop/working/w2d2/chess/stepping_piece.rb"



class SlidingPiece < Piece

  def initialize(color, pos, moved, board, type)
    super(color, pos, moved, board)
    @type = type
  end

  def moves
    case @type
    when :rook
      deltas = [[0,1],[1,0],[-1,0],[0,-1]]
    when :bishop
      deltas = [[1,1],[-1,-1],[-1,1],[1,-1]]
    when :queen
      deltas = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    end
    list = []
    deltas.each { |delta| list += explore(delta) }
    list.uniq
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

board = Board.new
rook = SlidingPiece.new(:black, [4, 4], false, board, :rook)
# current = [0,0]
# p board.grid[current[0]][current[1]].nil?
# p rook.rook_move("right")
p rook.valid_moves

# p queen.valid_moves
# p queen.deltas
# + Rook
#   + #move_dirs()
#   + #symbol "R"
