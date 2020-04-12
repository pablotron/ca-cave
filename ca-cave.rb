#!/usr/bin/env ruby

#
# Ruby implementation of Cellular Automata Method for Generating Random
# Cave-Like Levels.
#
# Algorithm reference:
# http://roguebasin.roguelikedevelopment.org/index.php?title=Cellular_Automata_Method_for_Generating_Random_Cave-Like_Levels
#
module Cave
  #
  # Map implementation.
  #
  class Map
    attr :d, :w, :h, :iters, :fill

    #
    # Create a new map with the given parameters and return the string
    # result.
    #
    # * w: map width (positive integer > 2, required)
    # * h: map height (positive integer > 2, required)
    # * iters: number of smoothing iterations (positive integer,
    #   optional, defaults to 5)
    # * fill: initial ratio of filled cells (floating point
    #   number between 0 and 1 inclusive, optional, defaults to 0.45)
    #
    def self.run(w, h, iters = 5, fill = 0.45)
      new(w, h).to_s
    end

    #
    # Create a new map with the given width and height.
    #
    # Parameters:
    # * w: width (positive integer, required)
    # * h: height (positive integer, required)
    # * iters: number of smoothing iterations (positive integer,
    #   optional, defaults to 5)
    # * fill: initial ratio of filled cells (floating point
    #   number between 0 and 1, optional, defaults to 0.45)
    #
    def initialize(w, h, iters = 5, fill = 0.45)
      # generate data
      @d = gen(w, h, iters, fill)

      # cache attributes
      @w, @h, @iters, @fill = w, h, iters, fill
    end

    #
    # Returns a printable ASCII string of this map.
    #
    def to_s
      @h.times.map { |y|
        @d[y * @w, @w].map { |v| v ? '#' : '.' }.join
      }.join("\n")
    end

    private

    #
    # Returns 1 if the given cell is filled or out of bounds and zero
    # otherwise.
    # 
    def f(x, y, r, w, h)
      ok = (x >= 0) && (y >= 0) && (x < w) && (y < h)
      ok ? (r[y * w + x] ? 1 : 0) : 1
    end

    #
    # Get the number of filled adjacent cells.
    #
    # Parameters:
    # * i: cell index
    # * r: map data
    # * w: map width
    # * w: map height
    #
    def num_filled(i, r, w, h)
      y, x = i / w, i % w

      # first row
      f(x - 1, y - 1, r, w, h) +
      f(x - 0, y - 1, r, w, h) +
      f(x + 1, y - 1, r, w, h) +

      # second row
      f(x - 1, y - 0, r, w, h) +
      f(x + 1, y - 0, r, w, h) +

      # third row
      f(x - 1, y + 1, r, w, h) +
      f(x - 0, y + 1, r, w, h) +
      f(x - 1, y + 1, r, w, h)
    end

    #
    # Generate map data.
    #
    # Parameters:
    # * w: width (positive integer, required)
    # * h: height (positive integer, required)
    # * iters: number of smoothing iterations (positive integer,
    #   optional, defaults to 5)
    # * fill: initial ratio of filled cells (floating point
    #   number between 0 and 1, optional, defaults to 0.45)
    #
    # Returns an array of cells, where each entry is true if the cell is
    # filled and false otherwise.
    #
    def gen(w, h, iters = 5, fill = 0.45)
      iters.times.reduce(Array.new(w * h) { rand() < fill }) do |r, i|
        r.size.times.map { |i|
          # number of filled neighbors
          num = num_filled(i, r, w, h)

          # 4-5 rule
          (r[i] && (num > 3)) || (!r[i] && (num > 4))
        }
      end
    end
  end

  #
  # Namespace for command-line interface.
  #
  module CLI
    # default map size
    DEFAULT_SIZE = [80, 30]

    #
    # Command-line entry point
    #
    def self.run(app, args)
      w, h = (args.size == 2) ? args.map { |v| v.to_i } : DEFAULT_SIZE
      puts Map.run(w, h)
    end
  end
end

# allow command-line invocation
Cave::CLI.run($0, ARGV) if __FILE__ == $0
