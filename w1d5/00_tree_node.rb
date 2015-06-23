class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def parent=(node)
    old_parent = @parent unless node == @parent
    @parent = node
    # @parent.add_child(self)
    @parent.children << self unless node.nil? || @parent.children.include?(self)
    if !old_parent.nil?
      old_parent.children.delete(self)
    end
  end

  def add_child(child_node)
    self.children << child_node unless child_node.nil? || self.children.include?(child_node)
    child_node.parent = self
  end


  def remove_child(child)
    raise "This is not a child." if child.parent == nil
    child.parent = nil
  end

  def children
    @children
  end

  def value
    @value
  end

  def dfs(target_value)
    if self.value == target_value
      return self
    else self.children.each do |child|
        child_value = child.dfs(target_value)
        if !child_value.nil?
          return child_value
        end
      end
    end
    return nil
  end


  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty?
      curr = queue.shift
      if(curr.value == target_value)
        return curr
      end

      queue = queue + curr.children
    end
    nil
  end

  def trace_path_back
    positions = [self.value]
    current_node = self
    while !current_node.parent.nil?
      positions.unshift(current_node.parent.value)
      current_node = current_node.parent
    end

    positions
  end

end
