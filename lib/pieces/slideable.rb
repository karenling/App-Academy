module Slideable

  def horizontal_dirs
    [[0,1],[1,0],[-1,0],[0,-1]]
  end

  def diagonal_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1]]
  end

  def explore(dir)
    y_diff = dir.first
    x_diff = dir.last
    deltas = []
    current = @pos.dup

    start = nil
    while start.nil?
      deltas << current.dup
      current[0] += y_diff
      current[1] += x_diff
      break unless current.all? { |ele| ele.between?(0,7) }
      start = @board.grid[current.first][current.last]
    end
    deltas << current.dup

    deltas.select do |position|
      position.all? { |coordinate| coordinate.between?(0,7) }
    end
  end
  
end

#
# # while current.all? { |ele| ele.between?(0,7) }
# while true
#   if (current[0] + y_diff).between?(0,7) && (current[1] + x_diff).between?(0,7)
#     current[0] += y_diff
#     current[1] += x_diff
#     deltas << current.dup
#   end
#
#   break unless @board.grid[current.first][current.last].nil?
# end
