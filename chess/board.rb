

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def display
    puts "    A   B   C   D   E   F   G   H"

    @grid.each_with_index do |row, index|
      puts "#{index} #{row}\n\n"
    end
    true
  end

  def on_board?

  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def occupied?(pos)
    !@grid[pos.first][pos.last].nil?
  end

  def piece_at(pos)
    @grid[pos.first][post.last]
  end

  def checkmate?
    #king is checked and has no valid moves
  end

  def check?

  end

  def deep_dup

  end

end

game = Board.new
p game.display
