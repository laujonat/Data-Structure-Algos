require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  result, queued = [], []

  vertices.each do |vertex|
    queued.push(vertex) if vertex.in_edges.empty?
  end

  while queued.length != 0
    shifted = queued.shift
    result.push(shifted)

    until shifted.out_edges.empty?
      current_edge = shifted.out_edges.pop
      if current_edge.to_vertex.in_edges.length == 1
        queued.push(current_edge.to_vertex)
      end

      current_edge.destroy!
    end
  end

  return [] unless result.length == vertices.length
  result
end
