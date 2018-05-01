require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    idx = (index + @start_idx) % @capacity
    @store[idx]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    idx = (index + @start_idx) % @capacity
    @store[idx] = val
  end

  # O(1)
  def pop
    check_index(@length - 1)
    @length -= 1
    last_index = (@start_idx + @length) % @capacity
    val = @store[last_index]
    @store[last_index] = nil
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length + 1 > @capacity
    last_index = (@start_idx + @length) % @capacity
    @length += 1
    @store[last_index] = val
  end

  # O(1)
  def shift
    check_index(@length - 1)
    shifted = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length + 1 > @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < @length
  end

  def resize!
    @capacity *= 2
    new_arr = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_arr[i] = @store[(@start_idx + i) % @length]
      i += 1
    end
    @start_idx = 0
    @store = new_arr
  end
end
