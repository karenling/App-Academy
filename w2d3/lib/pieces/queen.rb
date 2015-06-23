class Queen < Piece
  include Slideable

  def valid_moves
    super
  end

  def display
    case @color
    when :black
      print "\u265B"
    when :white
      print "\u2655"
    end
  end
  #call moves(horizontal)

  def moves
    list = []
    (horizontal_dirs + diagonal_dirs).each { |delta| list += explore(delta) }
    list.uniq
  end

end
