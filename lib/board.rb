require_relative 'piece'
require 'colorize'

class Board
  attr_reader :grid



  def self.blank_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = self.class.blank_grid, clone = false)
    @grid = grid
    @clone = clone
    unless @clone
      populate_board(:black)
      populate_board(:white)
    end

  end

# move = try to do move! then return if it has an error
  def move(start, end_pos)
    moving_piece = @grid[start.first][start.last]
    if moving_piece.valid_moves.include?(end_pos)
      move!(start, end_pos)
    else
      raise "Invalid Move"
    end
  end

  def move!(start, end_pos)
    moving_piece = @grid[start.first][start.last]

    moving_piece.pos = end_pos
    @grid[start.first][start.last] = nil
    @grid[end_pos.first][end_pos.last] = moving_piece
  end


  def populate_board(color)

    sliding_positions = {
      :rook => [[0,0],[0,7]],
      :bishop => [[0,2],[0,5]],
      :queen => [[0,3]]
    }

    stepping_positions = {
      :king => [[0,4]],
      :knight => [[0,1],[0,6]]
    }

    case color
    when :black
      pawn_index = 1
    when :white
      sliding_positions.each do |key, value|
        sliding_positions[key] = value.map { |pair| [7 - pair.first, pair.last] }
      end
      stepping_positions.each do |key, value|
        stepping_positions[key] = value.map { |pair| [7 - pair.first, pair.last] }
      end
      pawn_index = 6
    end

    @grid = @grid.map.with_index do |row, row_index|

      row.map.with_index do |col, col_index|
        if row_index == pawn_index
          Pawn.new(color, [row_index, col_index], false, self)
        else
          col
        end
      end
    end

    sliding_positions[:rook].each do |coord|
      @grid[coord.first][coord.last] =
        Rook.new(color, [coord.first, coord.last], false, self)
    end

    sliding_positions[:bishop].each do |coord|
      @grid[coord.first][coord.last] =
        Bishop.new(color, [coord.first, coord.last], false, self)
    end

    sliding_positions[:queen].each do |coord|
      @grid[coord.first][coord.last] =
        Queen.new(color, [coord.first, coord.last], false, self)
    end

    stepping_positions[:knight].each do |coord|
      @grid[coord.first][coord.last] =
        Knight.new(color, [coord.first, coord.last], false, self)
    end

    stepping_positions[:king].each do |coord|
      @grid[coord.first][coord.last] =
        King.new(color, [coord.first, coord.last], false, self)
    end

  end

  def display_board

    puts "   A  B  C  D  E  F  G  H"


    @grid.each_with_index do |row, row_index|
      print "#{8 - row_index}  "
      row.each_with_index do |col, col_index|
        if col.nil?
          print "-- "
        else
          print " #{col.display} "
        end
      end
      print "\n"
    end
    "chess!"
  end

  # def [](row, col)
  #   @grid[row][col]
  # end
  #
  # def []=(row, col, mark)
  #   @grid[row][col] = mark
  # end

  def occupied?(pos)
    !@grid[pos.first][pos.last].nil?
  end

  def piece_at(pos)
    @grid[pos.first][post.last]
  end

  def checkmate?(color)
    if in_check?(color)
      pieces(color).each do |piece|
        piece.valid_moves.each do |valid_move|
          duplicated_board = self.deep_dup
          duplicated_board.move(piece.pos, valid_move)
          return false unless duplicated_board.in_check?(color)
        end
      end
      true
    else
      false
    end
  end

  def in_check?(color)
    king_pos = find_the_king(color).pos

    case color
    when :white
      color = :black
    when :black
      color = :white
    end
    pieces(color).any? { |piece| piece.valid_moves.include?(king_pos) }
  end

  def pieces(color)
    pieces = @grid.flatten.compact
    pieces.select { |piece| piece.color == color }
  end

  def find_the_king(color)
    pieces(color).find { |piece| piece.is_a?(King) }
  end

  def deep_dup
    duplicate = Board.new(self.class.blank_grid, true)
    self.grid.flatten.compact.each do |piece|
      duplicate.grid[piece.pos.first][piece.pos.last] = piece.class.new(piece.color, piece.pos.dup, piece.moved, duplicate)
    end
    duplicate
  end

end

# game = Board.new
# p game.display_board
#
# game.move([6,5],[5,5])
# game.move([1,4],[3,4])
# game.move([6,6],[4,6])
# game.move([0,3],[4,7])
# game.move!([7,5],[5,4])
#
# p game.display_board
#
# p game.checkmate?(:white)
