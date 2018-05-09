require_relative 'binary_search_tree'
require_relative 'bst_node'

def kth_largest(tree_node, k)
  kth_node = { node: nil, count: 0 }
  tree_reversed_order(tree_node, kth_node, k)[:node]
end

def tree_reversed_order(tree_node, kth_node, k)
  if tree_node && kth_node[:count] <= k
    kth_node = tree_reversed_order(tree_node.right, kth_node, k)
    if kth_node[:count] < k
      kth_node[:count] += 1
      kth_node[:node] = tree_node
    end

    if kth_node[:count] < k
      kth_node = tree_reversed_order(tree_node.left, kth_node, k)
    end
  end
  kth_node
end
