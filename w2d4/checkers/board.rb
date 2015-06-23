require 'colorize'
require_relative 'piece'

class Board
  attr_reader :grid, :deep_dup

  def initialize(clone = false)
    @clone = clone
    @grid = Array.new(8) { Array.new(8) { nil } }
    populate_board unless clone
  end

  def display_board
    puts "\n   0  1  2  3  4  5  6  7\n"
    @grid.each_with_index do |row, row_index|
      print "#{row_index} "
      row.each_with_index do |square, square_index|
        if (row_index + square_index).odd?
          print !square.nil? ? " #{square.display}".colorize(:background => :light_black) : "   ".colorize(:background => :light_black)
        else
          print !square.nil? ? " #{square.display}".colorize(:background => :light_white) : "   ".colorize(:background => :light_white)
        end
      end
      puts ""
    end
  end

  def deep_dup
    duplicate = Board.new(true)
    all_pieces.each do |piece|
      duplicate.grid[piece.pos[0]][piece.pos[1]] =
      Piece.new(piece.color, piece.pos, piece.king, duplicate)
    end
    duplicate
  end

  def add_piece(color, pos)
    @grid[pos.first][pos.last] = Piece.new(color, pos, false, self)
  end

  def populate_board
    black_pieces = [
      [7, 1], [7, 3], [7, 5], [7, 7], [6, 0], [6, 2], [6, 4], [6, 6],
      [5, 1], [5, 3], [5, 5], [5, 7] ]

    red_pieces = [
      [0, 0], [0, 2], [0, 4], [0, 6], [1, 1], [1, 3], [1, 5], [1, 7],
      [2, 0], [2, 2], [2, 4], [2, 6] ]

    black_pieces.each do |black_piece|
      position = [black_piece[0], black_piece[1]]
      self.add_piece(:black, position)
    end

    red_pieces.each do |red_piece|
      position = [red_piece[0], red_piece[1]]
      self.add_piece(:red, position)
    end
  end

  def all_pieces
    @grid.flatten.compact
  end

  def all_color_pieces(color)
    pieces = @grid.flatten.compact
    pieces.select { |piece| piece.color == color }
  end



end

# board = Board.new
#
#
# board.display_board
# board.grid[2][2].perform_slide([3, 3])
# board.display_board
# board.grid[3][3].perform_moves!([4, 4])
# board.display_board
# board.grid[1][1] = nil
# board.display_board
# board.grid[1][3].perform_moves!([2, 2])
# board.display_board
# board.grid[5][5].perform_moves!([3, 3], [1, 1])
# board.display_board

# board.grid[1][5].perform_moves!([2, 4])
# board.display_board
# board.grid[5][1].perform_moves!([3, 3], [1, 5])
# #
# board.display_board

=begin
board = Board.new
board.grid[2][2].perform_moves([3, 3])
board.display_board

# board.grid[2][2].perform_moves([3, 3])
# p board_display

#black character at bottom
board = Board.new
# board.display_board

black1 = board.grid[5][5]
black1.perform_slide([4, 4])
board.display_board
p board.grid[5][5]
#
red1 = board.grid[2][2]
p red1.perform_moves([3, 3])
board.display_board

black2 = board.grid[4][4]
black2.perform_jump([2, 6])
board.display_board

red2 = board.grid[1][7]
red2.perform_jump([3, 5])
board.display_board

black3 = board.grid[5][3]
black3.perform_slide([4, 4])
board.display_board

red3 = board.grid[3][5]
red3.perform_jump([5, 3])
board.display_board

puts "\n\n\n***checking if promote to king works***"
board.grid[6][4] = nil
board.grid[7][5] = nil
red4 = board.grid[5][3]
red4.perform_slide([6, 4])
red4.perform_slide([7, 5])
board.display_board

puts "\n\n\n*** check that the king can slide backwards***"
board.grid[6][6] = nil
board.display_board
red4.perform_slide([6, 6])
board.display_board
red4.perform_slide([5, 5])
board.display_board

# puts "\n\n\n***check that non-kings cannot slide backwards***"
# black4 = board.grid[5][7]
# black4.perform_slide([6, 6])
# board.display_board

puts "\n\n\n***check that kings can jump forward***".center(40)
red_king = board.grid[5][5]
board.add_piece(:black, [4, 4])
board.display_board
red_king.perform_jump([3, 3])
board.display_board

puts "\n\n\n***check that kings can jump backwards***"
board.add_piece(:black, [4, 4])
board.display_board
red_king.perform_jump([5, 5])
board.display_board

puts "\n\n\n***check that kings can jump backwards again***"
black5 = board.grid[7][3]
black5.perform_slide([6, 4])
board.display_board
red_king.perform_jump([7, 3])
board.display_board
#
puts "\n\n\n***check that kings can jump forward***"
board.grid[5][1] = nil
board.display_board
red_king.perform_jump([5, 1])
board.display_board

puts "\n\n\n***check non-king can jump and eat king***"
black6 = board.grid[6][0]
black6.perform_jump([4, 2])
board.display_board

# puts "\n\n\n***make an invalid slide***"
# black6 = board.grid[7][1]
# black6.perform_slide([5, 3])
# board.display_board

puts "\n\n\n***check that black king can move in every direction***"
black7 = board.grid[4][2]
black7.promote_to_king
black7.perform_slide([5, 3])
#create a red piece to let black king jump backwards
board.add_piece(:red, [6, 4])
black7.perform_jump([7, 5])
board.display_board

puts "\n\n\n***trying perform_moves! with one move (slide)***"
p black7.pos
black7.perform_moves!([6, 6])
board.display_board

puts "\n\n\n***trying perform_moves! with multiple valid jumps***"
#set up board to allow black king to do multiple jumps
board.display_board
board.add_piece(:red, [5, 5])
board.grid[2][2].perform_moves!([3, 3])
board.display_board
black7.perform_moves!([4, 4], [2, 2])
board.display_board

puts "\n\n\n***check that deep_dup is working properly***"
puts "vvvvv original board vvvvv"
board.add_piece(:red, [3, 5])
board.display_board
duplicate = board.deep_dup
# duplicate.display_board
duplicate.add_piece(:red, [6,0])
puts "vvvvv duplicated board with added piece vvvvv"
duplicate.display_board
#duplicate board and original board should be different now

puts "\n\n\n***valid move sequence***"

puts "\n\n\n***duplicate is of different object id***"
starting = duplicate.grid[3][5]
duplicate.display_board
starting.perform_slide([4, 4])

duplicate.display_board

puts "\n\n\n***verify no errors with valid sequence in perform_moves***"
board.display_board
board.add_piece(:red, [3, 3])
board.add_piece(:red, [5, 5])
board.display_board
starting = board.grid[2][2]
puts "\n\n\n***check that this is a valid sequence***"
p starting.valid_move_seq?([4, 4], [6, 6])
puts "\n\n\n***our original board should not be altered if it is a valid sequence***"
board.display_board
# we only execute starting.perform_moves!([4, 4], [6, 6]) if valid_move_seq returns true
starting.perform_moves([4, 4], [6, 5])
board.display_board
# starting.perform_moves!([4, 4], [6, 6])
# board.display_board

#
# puts "\n\n\n***trying perform_moves! with multiple jumps in various directions***"
# #set up board to allow black king to do multiple jumps
# board.grid[2][4].perform_moves!([3, 3])
# board.add_piece(:red, [5, 3])
# black7.perform_moves!([4, 4], [6, 2])
# board.display_board
# #
# #
# # puts "\n\n\n***trying perform_moves! with multiple jumps with an error***"
# # #set up board to allow black king to do multiple jumps
# # board.add_piece(:red, [5, 3])
# # board.add_piece(:red, [3, 5])
# # board.display_board
# # black7.perform_moves!([4, 4], [4, 6])
# # board.display_board
#
#
#
# puts "\n\n\n***check that deep_dup is working properly***"
# puts "vvvvv original board vvvvv"
# board.display_board
# duplicate = board.deep_dup
# # duplicate.display_board
# duplicate.add_piece(:red, [6,0])
# puts "vvvvv duplicated board with added piece vvvvv"
# duplicate.display_board
# #duplicate board and original board should be different now

#
# puts "\n\n\n***trying perform_moves! with one move (jump)***"
# board.add_piece([6,4])
# board.display_board
# # black7.perform_moves!([6, 6])
# # board.display_board

=end
