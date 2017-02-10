class Tree
  class Node
    attr_accessor :value, :parent, :left, :right
    def initialize(value, parent=nil)
      @value = value
      @parent = parent
      @left = nil
      @right = nil
    end
  end

  def initialize
    @root = nil
  end

  def insert(key)
    current_node = @root
    if @root == nil
      @root = Node.new(key)
    end

    until current_node == nil
      if (key <=> current_node.value) < 0
        if current_node.left == nil
          current_node.left = Node.new(key, current_node)
          return nil
        else
          current_node = current_node.left
        end
      elsif (key <=> current_node.value) > 0
        if current_node.right == nil
          current_node.right = Node.new(key, current_node)
          return nil
        else
          current_node = current_node.right
        end
      else
        return nil
      end
    end
  end

  def breadth_first_search(key)
    queue = []
    queue.push(@root)
    while queue.length > 0
      current_node = queue.shift
      if key == current_node.value
        return current_node
      end
      if current_node.left != nil
        queue.push(current_node.left)
      end
      if current_node.right != nil
        queue.push(current_node.right)
      end
    end
    return nil
  end

  def depth_first_search(key)
    stack = []
    current_node = @root
    while stack.length > 0 || current_node != nil
      if current_node != nil
        stack.push(current_node)
        current_node = current_node.left
      else
        current_node = stack.pop
        if current_node.value == key
          return current_node
        end
        current_node = current_node.right
      end
    end
    return nil
  end

  def dfs_rec(key)
    def dfs_call(key, node)
      if node == nil
        return nil
      end
        search = dfs_call(key, node.left)
        return search unless search.nil?
        if node.value == key
          return node
        end
        search = dfs_call(key, node.right)
    end
    current_node = @root
    dfs_call(key, current_node)
  end
end

def build_tree array
  tree = Tree.new
  until array.empty?
    tree.insert(array.shift)
  end
  return tree
end

=begin tests
ary = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = build_tree ary
puts tree.dfs_rec(1)
puts tree.dfs_rec(7)
puts tree.dfs_rec(4)
puts tree.dfs_rec(23)
puts tree.dfs_rec(8)
puts tree.dfs_rec(9)
puts tree.dfs_rec(4)
puts tree.dfs_rec(3)
puts tree.dfs_rec(5)
puts tree.dfs_rec(7)
puts tree.dfs_rec(9)
puts tree.dfs_rec(67)
puts tree.dfs_rec(6345)
puts tree.dfs_rec(324)
=end
