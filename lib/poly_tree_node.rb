class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children =  []
  end

  def parent=(parent_node)
    if @parent != nil
      @parent.children.delete(self)
    end
    @parent = parent_node
    if parent_node != nil
      parent_node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise Exception if !@children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return nil if self == nil
    return self if self.value == target_value
    @children.each do |child_node|
      search_result = child_node.dfs(target_value)
      return search_result unless search_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children.each { |child_node| queue.push(child_node) }
    end
    nil
  end

end