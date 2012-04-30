#!/usr/bin/env ruby

class Point
  attr_accessor :x, :y, :z, :name, :edges
  def initialize name, x, y, z = 0
  	@name, @x, @y, @z = name, x, y, z
    @edges = {}
  end

  def distance_to other, options = {:type => :euclidean}
  	return false unless options[:type]
  	case options[:type]
  	when :euclidean
  		Math.sqrt(
  			(@x - other.x)**2 + (@y - other.y)**2 + (@z - other.z)**2
      )
    when :manhattan
      (@x - other.x).abs + (@y - other.y).abs + (@z - other.z).abs
    end
  end

  def [] other
    @edges[other]
  end

  def []= other, edge
    @edges[other] = edge
  end

  def to_s
    "Point: #{@name}"
  end

  def minimum_edge
    @edges.min_by {|name, edge| edge.weight}.last
  end
end
