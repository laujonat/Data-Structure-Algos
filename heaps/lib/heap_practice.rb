require_relative "heap"

class MedianHeap

  def initialize
    prc = Proc.new { |x, y| y <=> x }
    @lower_heap = BinaryMinHeap.new(&prc)
    @upper_heap = BinaryMinHeap.new
    @count = 0
  end

  def add(val)
    if @count <= 2
      @count += 1
      @lower_heap.push(val)
      if @count == 2
        @upper_heap.push(@lower_heap.extract)
      end
    end

    if @lower_heap.peek > val
      @lower_heap.push(val)
    else
      @upper_heap.push(val)
    end

    if @lower_heap.count > @upper_heap.count + 1
      @upper_heap.push(@lower_heap.extract)
    elsif @upper_heap.count > @lower_heap.count + 1
      @lower_heap.push(@upper_heap.extract)
    end
  end

  def find_median
    if @lower_heap.count > @upper_heap.count
      return @lower_heap.peek
    elsif @upper_heap.count > @lower_heap.count
      return @upper_heap.peek
    else
      return (@lower_heap.peek + @upper_heap.peek) / 2.0
    end
  end
end

median = MedianHeap.new
median.add(8)
p median.find_median
median.add(16)
p median.find_median
median.add(12)
p median.find_median
median.add(4)
p median.find_median
median.add(2)
p median.find_median
median.add(11)
p median.find_median
