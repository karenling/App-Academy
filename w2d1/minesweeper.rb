require 'bundler'
require 'yaml'
require 'colorize'


class Tile
  # @board = Board.new

  attr_accessor :tile_state
  def initialize(row, column, board, tile_state)
    @row = row
    @column = column
    @board = board
    @tile_state = tile_state

  end

  def bombed?
    return true if @board.bomb_areas.include?([@row, @column])
    return false
  end

  def flagged?
    return true if self.tile_state == " F "
    # return true
  end

  def revealed?
    return true if self.tile_state != " * "#.tile_state.is_a?(Integer)
  end

  def self.reveal(tile)
    tile.tile_state = " - "
  end

  def self.neighbors(row, column)

    neighbors = [
      [row - 1, column - 1],
      [row - 1, column],
      [row - 1, column + 1],
      [row, column - 1],
      [row, column + 1],
      [row + 1, column - 1],
      [row + 1, column],
      [row + 1, column + 1]
    ]
    neighbors
  end


  def neighbor_bomb_count
    adjacent_bomb_count = 0
    squares = Tile.neighbors(@row, @column)

    squares.each do |neighbor|
      adjacent_bomb_count +=1 if @board.bomb_areas.include?(neighbor)
    end


    if adjacent_bomb_count == 0
      # reveal fringe
        squares.each do |row, column|
          if row.between?(0, 8) && column.between?(0, 8)
            Tile.reveal(@board.[](row, column)) unless @board.[](row, column).revealed?
          end
        end
    end

    adjacent_bomb_count > 0 ? " #{adjacent_bomb_count} " : " _ "
  end

  def inspect
    tile_state
  end
end

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9)}
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end


  def bomb_areas
    bomb_locations = []
    srand 87
    10.times do |bomb|
      row = rand(9)
      column = rand(9)
      bomb_locations << [row, column] if !bomb_locations.include?([row, column])
    end
    bomb_locations
  end

  def new_game
    # create our board with numbers and bombs
    #10 bombs

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |square, column_index|
        tile_state = " * "
        @grid[row_index][column_index] = Tile.new(row_index, column_index, self, tile_state)
        # @grid[row_index][column_index] = "*"
      end
    end

  end

  def won?
    all_tiles = []
    @grid.each do |row|
      row.each do |tile|
        all_tiles << tile
      end
    end

    all_tiles.none? do |tile|
      tile.tile_state == " * "
    end


  end

  def play_game



    new_game
    puts "\n\n"

    print_board

    loop do
      puts "\n\nBOMB AREAS: #{bomb_areas}".colorize(:yellow)


      prompt = "Select a square to flag or reveal. " +
      "e.g. \"F 1, 2\" or \"R 1, 2\". \nEnter \"s\" " +
      "if you would like to save the game."

      puts prompt.colorize(:red)

      user_selection = gets.chomp.upcase.delete(",").split(" ")

      row = user_selection[1].to_i
      column = user_selection[2].to_i
      if user_selection[0] == "F"
        @grid[row][column].tile_state = " F "# @grid[row][column].flagged?
      elsif user_selection[0] == "R"

        if @grid[row][column].flagged?
          puts "Choose another tile.  You have already flagged this space."
        else
          if @grid[row][column].bombed?#bomb_areas.include?([row, column])
            puts "You lose! This is a bomb.".colorize(:red)
            break
          else #tile is not a bomb
            # byebug

            @grid[row][column].tile_state = @grid[row][column].neighbor_bomb_count
          end
        end
      elsif user_selection[0].upcase == "S"
        save
      end


      print_board
      if won?
        puts "You WON!"
        break
      end
    end


  end

  def print_board

    puts "      0    1    2    3    4    5    6    7    8\n".colorize(:magenta)
    i = 0
    @grid.each do |row|
      # p "_"*55
      row.map do |instance|
        instance = instance.tile_state
      end

      print "#{i}   ".colorize(:magenta)
      i += 1
      p row
      puts "\n"
    end

    #
    # # 9.times do |n|
    #   9.times { |i| p @grid[1][i] }
    # # end

  end

  def save
    puts "What filename would you like to save your game at?"
    filename = gets.chomp

    File.write(filename, YAML.dump(self))
  end

end

if $PROGRAM_NAME == __FILE__
  # running as script

  if ARGV.count == 1
    # p File.readlines(ARGV[0])
    YAML.load_file(ARGV.shift).play_game
  else
    Board.new.play_game
  end

  # case ARGV.count
  # when 0
  #   Board.new.play_game
  # when 1
  #   # p File.readlines(ARGV[0])
  #   # resume game, using first argument
  #   YAML.load_file(ARGV.shift).play_game
  #
  # end
end


# #
# game1 = Board.new
# # # game1.print_board
# # # game1.new_game
# # # p game1.grid
# game1.play_game
