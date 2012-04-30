#!/usr/bin/env ruby
class Parser
  class << self
    def parse! file_or_text
      matrix = read_from_file file_or_text
    end

    def read_from_file file_or_text
      if File.exists?(file_or_text)
        lines = File.read(file_or_text).split("\n")
      elsif file_or_text.is_a? File
        lines = file_or_text.lines.to_a
      else
        lines = file_or_text.split("\n")
      end

      num_sets = lines[1].to_i
      metric = lines[2].to_i   # 0 = Euclidean, 1 = Manahattan
      points = []
      lines[3..-1].each do |line|
        points << line.chomp.split.map(&:to_i)
      end

      metric = case metric
      when 0 then :euclidean
      when 1 then :manhattan
      else :euclidean
      end
      [num_sets, metric, points]
    end
  end
end
