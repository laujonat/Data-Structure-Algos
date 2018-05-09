# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'
require_relative 'graph'

def install_order(arr)
  max = arr.flatten.max
  ids = (1..max).to_a

  vertices = {}

  arr.each do |tuple|
    vertices[tuple[0]] = Vertex.new(tuple[0]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(tuple[1]) unless vertices[tuple[1]]
    Edge.new(vertices[tuple[1]], vertices[tuple[0]])
  end


   ids_without_dependency = []
   ids.each do |id|
     ids_without_dependency.push(id) if vertices[id] == nil
   end

   ids_without_dependency + topological_sort(vertices.values).map { |value| value.value}
end
