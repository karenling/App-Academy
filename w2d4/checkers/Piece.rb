# class InvalidMoveError < StandardError
# end
InvalidMoveError = Class.new(StandardError)

class Piece

  ONE_UP_RIGHT    =   [-1, 1]
  ONE_UP_LEFT     =   [-1, -1]
  ONE_DOWN_RIGHT  =   [1, 1]
  ONE_DOWN_LEFT   =   [1, -1]

  TWO_UP_RIGHT    =   [-2, 2]
  TWO_UP_LEFT     =   [-2, -2]
  TWO_DOWN_RIGHT  =   [2, 2]
  TWO_DOWN_LEFT   =   [2, -2]

  attr_accessor :perform_slide, :pos, :color, :king

  def initialize(color, pos, king = false, board)
    @color = color
    @pos = pos
    @king = king
    @board = board
  end

  def display
    uni_code = self.king ? (" \u25CE") : (" \u25CF")
    print (uni_code).colorize(:color => self.color, :background => :light_white)
  end

  def select_only_on_board(array)
    # only select positions within the board
    array.select do |coordinate|
      coordinate[0].between?(0, 7) && coordinate[1].between?(0, 7)
    end
  end

  def valid_move_seq?(*move_sequence)
    begin
      duplicate_board = @board.deep_dup
      # p "Starting position is #{self.pos}"
      # p "Ending position is #{move_sequence}"
      starting = duplicate_board.grid[self.pos[0]][self.pos[1]]
      #find the piece on the duplicated board, then run that one
      starting.perform_moves!(*move_sequence)
    rescue
      return false #invalid move_sequence
    end
    return true #successful move_sequence
  end

  def perform_moves(*move_sequence)
    if valid_move_seq?(*move_sequence)
      perform_moves!(*move_sequence)
    else
      raise InvalidMoveError.new "Not a valid move!"
    end
  end

  def perform_moves!(*move_sequence)
    begin
      # slides only happen once, so if they return error, we just
      # need to check the jumps
      perform_slide(move_sequence[0])
    rescue
      move_sequence.each do |move|
        perform_jump(move)
      end
    end
  end
# move one position
  def perform_slide(ending_position)

    # create all possible movements
    deltas = [ONE_UP_RIGHT, ONE_UP_LEFT] if @king == false
    deltas = [ONE_UP_RIGHT, ONE_UP_LEFT, ONE_DOWN_RIGHT, ONE_DOWN_LEFT] if @king == true

    #inverse deltas for red color pieces
    if @color == :red
      deltas = deltas.map { |delta| [delta[0]*(-1), delta[1]*(-1)] }
      # p deltas
    end
    # get the slide positions
    slideable_positions = deltas.map do |delta|
      [delta[0] + @pos[0], delta[1] + @pos[1]]
    end
    # p slideable_positions
    slideable_positions = select_only_on_board(slideable_positions)
    # p @board.grid[6][5]
    # reject the +1 movements if there is a piece at +1
    slideable_positions = slideable_positions.reject do |coordinate|
      !@board.grid[coordinate[0]][coordinate[1]].nil? #if (coordinate[0].between?(0, 7) && coordinate[1].between?(0, 7))
    end

    slideable_positions = select_only_on_board(slideable_positions)
    # p slideable_positions
    if slideable_positions.include?(ending_position)
      move(ending_position)
      return true
    else
      # begin
        raise InvalidMoveError.new "Not a valid move!"
      # rescue InvalidMoveError => e
      #   puts "That move wasn't valid Please choose another move."
      # end
      return false
    end
  end

  # jump over a single other color
  def perform_jump(ending_position)
    if @king
      deltas = TWO_UP_RIGHT, TWO_UP_LEFT, TWO_DOWN_RIGHT, TWO_DOWN_LEFT
    else
      deltas = TWO_UP_RIGHT, TWO_UP_LEFT
    end

    if @color == :red
      deltas = deltas.map { |delta| [delta[0]*(-1), delta[1]*(-1)] }
    end
    # plus_one_postions =
    # get the jump positions
    jumpable_positions = deltas.map do |delta|
      [delta[0] + @pos[0], delta[1] + @pos[1]]
    end

    jumpable_positions = select_only_on_board(jumpable_positions)

    blocker = nil
    # p "unvalidated jump positions: #{jumpable_positions}"
    # reject the jumpable positiosn that have something at the destination
    jumpable_positions = jumpable_positions.reject do |coordinate|
      # p "#{coordinate[0]}, #{coordinate[1]}"
     @board.grid[coordinate[0]][coordinate[1]]
    end
    # p "jump positions that have nothing at destination: #{jumpable_positions}"
    # select only the jumpable positons that have something in between
    difference = 1 # (self.color == :black ? 1 : -1)

    jumpable_positions = jumpable_positions.select do |coordinate|
      if coordinate[1] > @pos[1] && coordinate[0] < @pos[0] #jumping right up. target is [2, 6]. starting is [4, 4]
        #check that there is something at [3, 5] of opposite color
        in_between = @board.grid[coordinate[0]+difference][coordinate[1]-difference]
        in_between && in_between.color != self.color
      elsif coordinate[1] < @pos[1] && coordinate[0] < @pos[0] #jumping up left
        in_between = @board.grid[coordinate[0]+difference][coordinate[1]+difference]
        in_between && in_between.color != self.color
      elsif coordinate[1] < @pos[1] && coordinate[0] > @pos[0]#jumping down right #1, 7 to 3, 5
        in_between = @board.grid[coordinate[0]-difference][coordinate[1]+difference]
        in_between && in_between.color != self.color
      elsif coordinate[1] > @pos[1] && coordinate[0] > @pos[0] #jumping down left
        in_between = @board.grid[coordinate[0]-difference][coordinate[1]-difference]
        in_between && in_between.color != self.color
      end
    end
    # p "These are after filtering the ones with nothing in between: #{jumpable_positions}"

    if jumpable_positions.include?(ending_position)
      difference = 1#(self.color == :black ? 1 : -1)
      # find the in_between piece
      if ending_position[1] > @pos[1] && ending_position[0] < @pos[0] #jumping right up. target is [2, 6]. starting is [4, 4]
        #check that there is something at [3, 5] of opposite color
        in_between = @board.grid[ending_position[0]+difference][ending_position[1]-difference]
      elsif ending_position[1] < @pos[1] && ending_position[0] < @pos[0] #diagonal up left
        in_between = @board.grid[ending_position[0]+difference][ending_position[1]+difference]
      elsif ending_position[1] < @pos[1] && ending_position[0] > @pos[0]#jumping down left #1, 7 to 3, 5
        in_between = @board.grid[ending_position[0]-difference][ending_position[1]+difference]
      elsif ending_position[1] > @pos[1] && ending_position[0] > @pos[0] #for king: back-right
        in_between = @board.grid[ending_position[0]-difference][ending_position[1]-difference]
      end
      # delete in_between piece and make the move
      move(ending_position)
      @board.grid[in_between.pos[0]][in_between.pos[1]] = nil
      return true
    else
      # begin
        raise InvalidMoveError.new "InvalidMoveError: Not a valid move!"
      # rescue InvalidMoveError => e
      #   puts "That move wasn't valid Please choose another move."
      # end
      return false
    end
  end

  def move(ending_position)
    @board.grid[self.pos[0]][self.pos[1]] = nil
    self.pos = ending_position
    @board.grid[ending_position[0]][ending_position[1]] = self
    maybe_promote
  end

  def maybe_promote
    # Make sure to possibly promote after each move;
    # I wrote a method #maybe_promote which checked to
    # see if the piece reached the back row.
    if (color == :red && pos[0] == 7) || (color == :black && pos[0] == 0)
      promote_to_king
    end
  end

  def promote_to_king
    # back row for black is when position[0] is 0
    # back row for red is when position[0] is 7
    @king = true
  end
end
