#!/usr/bin/env ruby

class Edge
  attr_accessor :a, :b

  def initialize a, b
    @a, @b = a, b
  end

  def weight
    @a.distance_to @b
  end

  def to_s
    "Edge: (#{@a.to_s}, #{@b.to_s})"
  end
end