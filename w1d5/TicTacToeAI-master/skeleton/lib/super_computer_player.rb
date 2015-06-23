require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root = TicTacToeNode.new(game.board, mark, nil)

    root.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
      return child.prev_move_pos if !child.losing_node?(mark)
    end

    # root.children.each do |child|
    #   return child.prev_move_pos if !child.losing_node?(mark)
    # end

    raise "No non-losing-nodes!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Player")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
