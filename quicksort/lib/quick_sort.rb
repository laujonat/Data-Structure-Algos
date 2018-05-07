class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 0

    pivot = rand(1..array.length-1)
    left = array[1..-1].select { |el| el < pivot }
    right = array[1..-1].select { |el| el >= pivot }

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el, el1| el <=> el1 }

   return if length <= 1
   # split into left and right sides
   pivot_idx = partition(array, start, length, &prc)

   left_length = pivot_idx - start
   right_length = length - (left_length + 1)

   sort2!(array, start, left_length, &prc)
   sort2!(array, pivot_idx + 1, right_length, &prc)

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el, el1| el <=> el1 }

    pivot_idx = start
    pivot = array[start]
    boundary = start + 1
    (boundary...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]

    pivot_idx
  end
end
