require_relative "heap"

class Array
  def heap_sort!
   1.upto(length - 1) do |idx|
     BinaryMinHeap.heapify_up(self, idx) { |el, el1| el <=> el1 }
   end

   (length - 1).downto(0) do |idx|
     self[0], self[idx] = self[idx], self[0]
     BinaryMinHeap.heapify_down(self, 0, idx) { |el, el2| el <=> el2 }
   end
 reverse!
 end
end
