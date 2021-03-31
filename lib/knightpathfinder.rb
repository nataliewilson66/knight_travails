require_relative 'poly_tree_node'

class KnightPathFinder

  def initialize(position)
    @root_node = PolyTreeNode.new(position)
    @considered_positions = [position]
    build_move_tree
  end

  def KnightPathFinder.valid_moves(pos)
    moves = []
    row, col = pos
    (-2..2).each do |i|
      new_row = row + i
      if i == 1 || i == -1
        new_col = col + 2
        moves << [new_row, new_col] if (new_row >= 0 && new_row < 8) && (new_col >= 0 && new_col < 8)
        new_col = col - 2
        moves << [new_row, new_col] if (new_row >= 0 && new_row < 8) && (new_col >= 0 && new_col < 8)
      elsif i == 2 || i == -2
        new_col = col + 1
        moves << [new_row, new_col] if (new_row >= 0 && new_row < 8) && (new_col >= 0 && new_col < 8)
        new_col = col - 1
        moves << [new_row, new_col] if (new_row >= 0 && new_row < 8) && (new_col >= 0 && new_col < 8)
      end
    end
    moves
  end

  def new_move_positions(pos)
    new_positions = []
    all_possible_moves = KnightPathFinder.valid_moves(pos)
    all_possible_moves.each do |elem|
      if !@considered_positions.include?(elem)
        new_positions << elem
        @considered_positions << elem
      end
    end
    new_positions
  end

  def build_move_tree
    queue = [@root_node]
    until queue.empty?
      current_root = queue.shift
      move_positions = new_move_positions(current_root.value)
      move_positions.each do |pos|
        child_node = PolyTreeNode.new(pos)
        current_root.add_child(child_node)
        queue.push(child_node)
      end
    end
    @root_node
  end

  def trace_path_back(target_node)
    path_arr = [target_node.value]
    if target_node == @root_node
      return [@root_node.value]
    else
      return path_arr + trace_path_back(target_node.parent)
    end
  end

  def find_path(end_pos)
    target_node = @root_node.bfs(end_pos)
    trace_path_back(target_node).reverse
  end

end

kpf = KnightPathFinder.new([0, 0])
print kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
puts
print kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
puts