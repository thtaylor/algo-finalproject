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
      pp create_partitions_from_edges edges
    end

    def create_partitions_from_edges edges
      partitions = []
      
    end
  end
end