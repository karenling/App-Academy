require_relative "piece.rb"

class Pawn < Piece

  def moves
    list = [[1, 0], [2, 0], [-1, -1], [-1, 1]]
    #filter move [2,0] if turn is first
  end

end
