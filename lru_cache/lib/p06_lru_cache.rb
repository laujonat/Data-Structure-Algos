require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # check if key points to any node in hash map
    if @map.include?(key)
      node = @map.get(key)
      update_node!(node) # move to end
    else
      # key is not in hash map
      # check if current count is greater than the max
      eject! if count >= @max
      node = calc!(key)
    end
    node.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

    # you call the proc using your key as input;
    val = @prc.call(key)
    node = @store.append(key, val)
    # add key to hash with pointer to new node
    @map.set(key, node)
    node
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    # @map.delete(node.key)
    @store.remove(node.key)

    list = @store.append(node.key, node.val) # place at end of linked list
    # @map.set(node.key, list) # reassign our hash map key and repoint to list
    # .append returns node
    list
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
    nil
  end
end
