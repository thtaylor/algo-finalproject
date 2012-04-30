#!/usr/bin/env ruby

require 'point'
require 'edge'
require 'algorithms'
include Containers

class Graph
  attr_accessor :points, :mst

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

  ##########################
  ## An implementation of Dijkstra's
  ## shortest path algorithm
  ## Biggest thing of note here:
  ## all of the Points are referred to by 'name'
  ##
  ##########################
  def dijkstra metric
    visited = {}
    distances = {}
    parent = {}
    queue = PriorityQueue.new {|x, y| (x <=> y) == -1}

    queue.push @points_by_name.first.last, 0
    visited[@points_by_name.first.first] = true
    @points_by_name.each_pair {|name, point| distances[name] = 1.0/0 }
    distances[@points_by_name.first.first] = 0

    while queue.size != 0
      u = queue.pop
      puts "Loop for: #{u.name} #{distances[u.name]}"
      visited[u.name] = true
      u.edges.keys.compact.each do |v|
        v = @points_by_name[v]
        alt = (distances[u.name] + u.distance_to(v, :type => metric))
        puts "Distance (#{u.to_s}->#{v.to_s}): alt #{alt}, dist[#{u.name}]: #{distances[u.name]}"
        if (alt < distances[v.name])
          distances[v.name] = alt
          parent[v.name] = u.name
          queue.push v, distances[v.name]
        end
      end
    end
    parent
  end

  def cut! k
  end
end
