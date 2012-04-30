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
      colors[name] = :white]
      distances[name] = 1.0/0
    end

    queue = PriorityQueue.new {|x, y| (x <=> y) == -1}
    colors[@points_by_name.first.first] = :grey
    queue << @points_by_name.first.last
    distances[@points_by_name.first.first] = 0

    until queue.empty?
      u = queue.pop
      u.edges.keys.each do |v|
        v = @points_by_name[v]
        if colors[v.name] == :white
          colors[v.name] = :grey
          queue.push @points_by_name[v.name], distances[v.name]
          distances[v.name] = u.distance_to v, :type => metric
          parents[v.name] = u.name
        elsif colors[u.name] == :grey
          if distances[v.name] > u.distance_to(v, :type => metric)
            distances[v.name] = u.distance_to(v, :type => metric)
            parents[v.name] = u.name
          end
        end
        colors[v.name] = black
      end

      parents
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
  ## The method returns an array of arrays
  ## of the format:
  ##
  ##   [
  ##     [partition 1],
  ##     [partition 2],
  ##     [partition 3],
  ##     etc.
  ##   ]
  ## where each partition is at least two vertices
  ##########################
  def cut! k
    return false unless @minimum_spanning_tree
    @minimum_spanning_tree.each 
    (k-1).times do |i|

    end
  end

  def prims metric
    starting_point = @points_by_name.first.last
    treed = [starting_point]
    non_treed = @points_by_name.dup - [starting_point]
    edges = []
    until non_treed.empty?
      minimum = treed.min_by {|point| point.minimum_edge }
      unless self.class.has_cycle? treed
        treed << minimum.b
        non_treed -= [minimum.b]
      end
    end
  end
  
  def Graph.has_cycle? points
    queue = Queue.new
    queue << points.first
    parents = {points.first.name => nil}
    marked = {points.first.name => true}
    until queue.empty?
      point = queue.pop
      return true if follow_parents(point, parents) == :cycle
      point.edges.values.map(&:b).each do |other|
        if !marked[other.name]
          parents[other.name] = point
          marked[other.name] = true
          queue << other
        end
      end
    end
  end

  def Graph.follow_parents point, parents
    visited = []
    until parents[point] == nil
      if visited.include? point.name
        return :cycle
      else
        visited << point.name
        point = parents[point]
      end
    end
  end
end
