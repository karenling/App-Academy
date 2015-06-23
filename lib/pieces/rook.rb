class Rook < Piece
  include Slideable

  def valid_moves
    super
  end

  def display
    case @color
    when :black
      print "\u265C"
    when :white
      print "\u2656"
    end
  end
  #call moves(horizontal)

  def moves
    list = []
    horizontal_dirs.each { |delta| list += explore(delta) }
    list.uniq
  end

end
#
