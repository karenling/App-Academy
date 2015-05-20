require './00_tree_node.rb'

class KnightPathFinder

  # attr_accessor :starting_position

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [starting_position]
  end

  def build_move_tree
    root = PolyTreeNode.new(@starting_position)
    queue = [root]
    until queue.empty?
      temp_node = queue.shift
      nodes = []
      new_moves = new_move_positions(temp_node.value)
      if !new_moves.nil?
        new_moves.each do |move|
          temp_node_2 = PolyTreeNode.new(move)
          temp_node.add_child(temp_node_2)
          nodes.push(temp_node_2)

        end
      end
      # p nodes
      queue = queue + nodes.dup
    end
    @visited_positions = [@starting_position]
    root
  end


  def find_path(end_pos)
    root = build_move_tree
    end_tree = root.dfs(end_pos)
    end_tree.trace_path_back

  end

  def new_move_positions(pos)
    new_moves = []
      KnightPathFinder.valid_moves(pos).each do |position|
        if !@visited_positions.include?(position)
          new_moves << position
        end
      end
      # need to create something to add to our @visited_positions
      @visited_positions = @visited_positions + new_moves


    return new_moves


  end

  def self.valid_moves(pos)
    x = pos[0]
    y = pos[1]

    moves = [[x-2,y + 1],[x-2,y-1],[x+2,y+1],[x+2,y-1],[x-1,y+2],[x+1,y-2],
    [x+1,y+2],[x-1,y-2]]
    valid_moves = []

    moves.each do |move|
      if move[0].between?(0 ,7) && move[1].between?(0 ,7)
        valid_moves << move
      end
    end

    valid_moves
  end


end

#
# kpf = KnightPathFinder.new([0, 0])
# # kpf.build_move_tree
#
# p kpf.find_path([7, 6])
# # kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
# # kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]
