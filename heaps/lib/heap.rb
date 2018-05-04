class BinaryMinHeap
  attr_reader :store, :prc
  # must be complete
  # each node  must be less than or equal to its parent

  # left : 2i + 1
  # right : 2i + 2
  # parent : (i - 1) / 2
  # insertion happens at O(logn)
  def initialize(&prc)
    @store = Array.new
    @prc = prc
  end

  def count
    @store.length
  end

  # pop O(logn)
  def extract
    # swap
    top = @store[0]
    @store[0] = @store[-1]
    @store[-1] = top

    # remove last element
    extracted_element = @store.pop

    #heapify down to place top in the correct place
    @store = BinaryMinHeap.heapify_down(@store, 0, &prc)
    extracted_element
  end

  # O(1)
  def peek
    # return minimum or maximum priority item
    @store[0]
  end

  # swap with parent until it obeys heap property
  # O(logn)
  def push(val)
    @store << val
    idx = count - 1
    @store = BinaryMinHeap.heapify_up(@store, idx, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    # return child indices that fall within array
    arr = []
    left = (2 * parent_index) + 1
    right = (2 * parent_index) + 2

    arr << left if left < len
    arr << right if right < len
    arr
  end

  def self.parent_index(child_index)
    # : (i - 1) / 2
    parent = (child_index - 1) / 2
    raise "root has no parent" unless parent >= 0
    parent
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el, el2| el <=> el2 }
    # find left and right indices
    arr = child_indices(len, parent_idx)
    left_child_idx, right_child_idx = arr[0], arr[1]
    # get parent value from array
    parent_value = array[parent_idx]

    children = []
    children << array[left_child_idx] if left_child_idx
    children << array[right_child_idx] if right_child_idx

    # must satisfy parent is less than or equal to children
    # check if both children are less than their parent
    # if they are, then they are in the right place, return array
    if children.all? { |child| prc.call(parent_value, child) <= 0 }
      return array
    end

    # if there is only one child in the array
    # we only need this as the single index we will swap 
    swap_idx = 0
    if children.length == 1
      swap_idx = left_child_idx
    else
      swap_idx =
        prc.call(children[0], children[1]) == -1 ? left_child_idx : right_child_idx
    end

    array[parent_idx], array[swap_idx] = array[swap_idx], parent_value
    heapify_down(array, swap_idx, len, &prc)



  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el, el2| el <=> el2 }
    # swap if child is greater than the parent
    return array if child_idx == 0

    parent_idx = BinaryMinHeap.parent_index(child_idx)
    child = array[child_idx]
    parent = array[parent_idx]

    # check if child is greater than parent
    if prc.call(child, parent) >= 0
     return array
   else
     array[child_idx] = parent
     array[parent_idx] = child
     BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
   end
  end
end
