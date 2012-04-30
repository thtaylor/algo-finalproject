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
      pp graph.dijkstra metric

      graph.cut! num_sets
    end
  end
end