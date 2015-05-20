class King < Piece
  include Stepable

  def valid_moves
    super
  end

  def display
    case @color
    when :black
      print "\u265A"
    when :white
      print "\u2654"
    end
  end
  #call moves(horizontal)

  def moves
    deltas = [[0,1],[1,0],[-1,0],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
    super(deltas)
  end

end
