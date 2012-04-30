#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)

require 'partitioner'

def args_valid?
  ARGV[0] && File.exists?(ARGV[0])
end

unless args_valid?
  puts usage
  exit 0
end

path = Partitioner.partition! ARGV[0]