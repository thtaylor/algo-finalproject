#!/usr/bin/env ruby

require 'point'
require 'edge'
require 'parser'
require 'graph'
require 'pp'

class Partitioner
  class << self
    def partition! filename
      num_sets, metric, points = Parser.parse! filename
      points = points.each_with_index.map {|p, i| Point.new i, *p }
      graph = Graph.new points
      graph.prims metric
      
      edges = graph.cut! num_sets
      create_and_print_partitions_from_edges edges
    end

    def create_and_print_partitions_from_edges edges
      partitions = []
      i = 0
      current_partition = 0
      until i >= edges.size
        partitions << []
        partitions[current_partition] << edges[i]
        while edges[i+1] && edges[i+1].a == edges[i].b
          i += 1
          partitions[current_partition] << edges[i]
        end
        i+=1
        current_partition +=1
      end
      partitions.each do |partition|
        vertices = []
        partition.each do |edge|
          vertices << edge.a
          vertices << edge.b
        end
        puts "{#{vertices.uniq.join ','}}"
      end
    end
  end
end