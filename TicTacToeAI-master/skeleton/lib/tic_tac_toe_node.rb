require 'byebug'

require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos unless nil
  end

  def losing_node?(evaluator)
    if @board.over?
      if evaluator == :x
        return @board.winner == :o ? true : false
      else
        return @board.winner == :x ? true : false
      end
    end

    if evaluator == :x
      if @next_mover_mark == :x
        return self.children.all? {|child| child.losing_node?(evaluator)}
      else
        return self.children.any? {|child| child.losing_node?(evaluator)}
      end
    elsif evaluator == :o
      if @next_mover_mark == :o
        return self.children.all? {|child| child.losing_node?(evaluator)}
      else
        return self.children.any? {|child| child.losing_node?(evaluator)}
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      if evaluator == :x
        return @board.winner == :x ? true : false
      else
        return @board.winner == :o ? true : false
      end
    end

    if evaluator == :x
      if @next_mover_mark == :x
        return self.children.any? {|child| child.winning_node?(evaluator)}
      else
        return self.children.all? {|child| child.winning_node?(evaluator)}
      end
    elsif evaluator == :o
      if @next_mover_mark == :o
        return self.children.any? {|child| child.winning_node?(evaluator)}
      else
        return self.children.all? {|child| child.winning_node?(evaluator)}
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_spaces = []
    nodes = []
    3.times do |r|
      3.times do |c|
          empty_spaces << [r,c] if @board.empty?([r,c])
      end
    end

    if @next_mover_mark == :x
      next_mover_mark_of_child = :o
    else
      next_mover_mark_of_child = :x
    end

    empty_spaces.each do |space|
      child_board = @board.dup
      child_board[space] = @next_mover_mark
      node = TicTacToeNode.new(child_board, next_mover_mark_of_child, space)
      nodes << node
    end

    nodes
  end
end
