# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    @root = traverse_and_insert(@root, value)
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if tree_node.value == value

    if value < tree_node.value
      target = find(value, tree_node.left)
    else
      target = find(value, tree_node.right)
    end

    target
  end

  def delete(value)
    target = find(value)
    if target == @root
      @root = nil
    end

    remove(target)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    while tree_node.right
      tree_node = tree_node.right
    end

    tree_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    return 0 if !tree_node.left && !tree_node.right
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node == nil

    left_depth = depth(tree_node.left)
    right_depth = depth(tree_node.right)

    left_depth - right_depth <= 1 && is_balanced?(tree_node.left) &&
      is_balanced?(tree_node.right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return if tree_node.nil?

    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)

    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:
  def traverse_and_insert(root, value)
   return BSTNode.new(value) unless root
   # compared value to root
   if value >= root.value
     # right side
     root.right = traverse_and_insert(root.right, value)
     root.right.parent = root
   else
     # left side
     root.left = traverse_and_insert(root.left, value)
     root.left.parent = root
   end

   root
 end

 def remove(node)
   if node.left == nil && node.right == nil
     remove_childless_node(node)

   elsif node.left && node.right.nil?
     node_with_only_left_child(node)

   elsif node.right && node.left.nil?
     node_with_only_right_child(node)

   else
     node_with_two_children(node)
   end
 end

 def remove_childless_node(node)
   if node.parent
     if node.parent.left == node
       node.parent.left = nil

     else
       node.parent.right = nil
     end
   end
 end

 def node_with_only_left_child(node)
   node.left.parent = node.parent

   if node.parent.left == node
     node.parent.left = node.left

   else
     node.parent.right = node.left
   end
 end

 def node_with_only_right_child(node)
   node.right.parent = node.parent

   if node.parent.left == node
     node.parent.left = node

   else
     node.parent.right = node.right
   end
 end

 def node_with_two_children(node)
   substitute_node = maximum(node.left)
   node.value = substitute_node.value
   remove(substitute_node)
 end

end
