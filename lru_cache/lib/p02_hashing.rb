class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
   hashed = 0.hash
   self.each_with_index do |el, i|
     hashed += el.hash
     hashed += i.hash
     hashed = hashed.hash
   end
   hashed.hash
 end
end

class String
  def hash
    hashed = "z".ord.hash
  	self.each_char.with_index do |char, idx|
  		hashed += char.ord.hash
      hashed += idx.hash
  		hashed = hashed.hash
  	end
  	hashed.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = []
  	self.each do |key, val|
  		arr << (key.hash + val.hash).hash
  	end
  	arr.sort.hash
  end
end
