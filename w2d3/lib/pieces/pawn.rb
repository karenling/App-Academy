class Pawn < Piece
  attr_reader :color

  def valid_moves
    moves
  end

  def display
    case @color
    when :black
      print "\u265F"
    when :white
      print "\u2659"
    end
  end

# create posible positions to move to
  def vertical_moves
    deltas = [[1, 0]]
    deltas << [2,0] unless moved?
    deltas.map! { |position| [position.first * -1, position.last]} if color == :white

    output = deltas.map do |diff|
      [diff.first + @pos.first, diff.last + @pos.last]
    end.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7) }
    end

    output.reject! do |pos|
      @board.grid[pos.first][pos.last]
    end

    output
  end

  def diagonal_moves
    deltas = [[1,-1],[1,1]]
    deltas.map! { |position| [position.first * -1, position.last]} if color == :white

    output = deltas.map do |diff|
      [diff.first + @pos.first, diff.last + @pos.last]
    end.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7) }
    end

    output.select! do |pos|
      occupied = @board.grid[pos.first][pos.last]
      if occupied
        occupied.color != self.color
      else
        false
      end
    end

    output
  end

  def moves
    vertical_moves + diagonal_moves
  end

end
