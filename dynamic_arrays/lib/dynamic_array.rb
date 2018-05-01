require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    check_index(@length - 1)
    val = @store[@length]
    @store[@length] = nil
    @length -= 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize! if @length > @capacity
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(@length - 1)
    new_arr = StaticArray.new(@capacity)
    shifted = @store[0]
    i = 1
    while i < @length
      new_arr[i-1] = @store[i]
      i += 1
    end
    @length -= 1
    @store = new_arr
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length + 1 > @capacity
    new_arr = StaticArray.new(@capacity)
    new_arr[0] = val
    @length += 1
    i = 1
    while i < @length
      new_arr[i] = store[i-1]
      i += 1
    end
    @store = new_arr
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_arr = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_arr[i] = @store[i]
      i += 1
    end
    @store = new_arr
  end
end
