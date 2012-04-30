#!/usr/bin/env ruby

require 'point'
require 'edge'
require 'algorithms'
include Containers

class Graph
  attr_accessor :points

  def initialize points
    @points_by_name = {}
    points.each {|point| @points_by_name[point.name] = point}
    @points_by_name.each do |pname, point|
      @points_by_name.each do |oname, other|
        next if pname == oname
        point[oname] = Edge.new point, other
      end
    end
  end

  #########################
  def prims metric
    colors = {}
    distances = {}
    parents = {}

    @points_by_name.each_pair do |name, point| 
      colors[name] = :white
      distances[name] = 1.0/0
    end

    #queue = PriorityQueue.new {|x, y| (x <=> y) == 1}
    queue = Queue.new
    colors[@points_by_name.first.first] = :grey
    queue.push @points_by_name.first.last#, 0
    distances[@points_by_name.first.first] = 0

    until queue.empty?
      pp queue
      u = queue.pop
      u.edges.keys.sort.each do |v|
        v = @points_by_name[v]
        puts "U: #{u.name}, V: #{v.name}"
        puts " parents[#{v.name}]=#{parents[v.name]}"
        if colors[v.name] == :white
          colors[v.name] = :grey
          queue.push @points_by_name[v.name]#, distances[v.name]
          distances[v.name] = u.distance_to v, :type => metric
          parents[v.name] = u.name
        elsif colors[v.name] == :grey
          alt = u.distance_to(v, :type => metric)
          if distances[v.name] > alt
            distances[v.name] = alt
            parents[v.name] = u.name
          end
        end
        puts "  parents[#{v.name}]=#{parents[v.name]}"
      end
      colors[u.name] = :black
    end

    @minimum_spanning_tree = parents
  end

  ##########################
  ## Accepting an integer, k, this
  ## method cuts the minimum spanning tree
  ## into k partitions.  
  ##
  ## The partitions are determined by
  ##   1) Max-sorting the edges by length
  ##   2) Severing the edges that are the longest
  ##      that still leaves at least two vertices
  ##      in a partition
  ## The method returns an array of edges
  ##########################
  def cut! k
    return false unless @minimum_spanning_tree
    edges = []
    @minimum_spanning_tree.each do |point, other|
      edges << Edge.new(@points_by_name[other], @points_by_name[point])
    end

    edges = edges.sort {|x, y| y <=> x}

    (k-1).times do |i|
      edges.delete edges.first
    end

    edges
  end
end
