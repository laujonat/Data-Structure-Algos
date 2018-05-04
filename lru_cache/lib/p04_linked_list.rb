class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node = Node.new(key,val)
    if empty?
      @head.next, node.prev = node, @head
      @tail.prev, node.next = node, @tail
    else
      old_node = @tail.prev
      old_node.next, node.prev = node, old_node
      @tail.prev, node.next = node, @tail
    end
    node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end

  end

  def remove(key)
    if include?(key)
      self.each do |node|
        if node.key == key
          node.remove
          return node.val
        end
      end
    end
  end

  def each
    node = @head.next
    until node == @tail
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
