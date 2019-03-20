#!/usr/bin/env jruby
require 'propane'# After an openprocessing sketch by C.Andrews
class RecursivePentagons < Propane::App
  attr_reader :strut_factor, :renderer

  def setup
    sketch_title 'Recursive Pentagons'
    @strut_factor = 0.2
    @renderer = GfxRender.new self.g # so we can send Vec2D :to_vertex
    background 0
  end

  def draw
    translate(width / 2, height / 2)
    angle = TWO_PI / 5
    radius = width * 0.7
    points = (0...5).map do |i|
      x = radius * cos(angle * i)
      y = radius * sin(angle * i)
      Vec2D.new(x, y)
    end
    fractal = PentagonFractal.new(points, 5)
    fractal.draw
  end

  def settings
    size(800, 800)
  end
end

RecursivePentagons.new

# Here we include Processing::Proxy to mimic vanilla processing inner class
# access.
class PentagonFractal
  include Propane::Proxy
  attr_reader :points ,:branches, :level, :midpoints, :innerpoints
  COLOURS = %w[#ff0000 #00ff00 #00ffff #0000ff #0000ff #ffffff]

  def initialize(points, levels)
    @points = points
    @level = levels
    return if level.zero? # so called guard clause in ruby simplifies code

    @midpoints = (0...5).map do |i| # build an array of midpoints
      midpoint(points[i], points[(i + 1) % 5])
    end
    @innerpoints = (0...5).map do |i| # build an array of inner points
      opposite = points[(i + 3) % 5]
      x = midpoints[i].x + (opposite.x - midpoints[i].x) * strut_factor
      y = midpoints[i].y + (opposite.y - midpoints[i].y) * strut_factor
      Vec2D.new(x, y)
    end
    # Create the PentagonFractal objects representing the six inner
    # pentagons
    # the shape is very regular, so we can build the ring of five
    @branches = (0...5).map do |i|
      p = [
        midpoints[i],
        innerpoints[i],
        innerpoints[(i + 1) % 5],
        midpoints[(i + 1) % 5],
        points[(i + 1) % 5]
      ]
      PentagonFractal.new(p, level - 1)
    end
    # add the final innermost pentagon
    branches << PentagonFractal.new(innerpoints, level - 1)
  end
  # This is a simple helper function that takes in two points (as Vec2D) and
  # returns the midpoint between them as Vec2D.
  def midpoint(point1, point2)
    (point2 + point1) * 0.5
  end

  def draw
    stroke 255
    no_fill
    begin_shape
    stroke_weight 0.5 + 0.75 * level
    stroke color(COLOURS[level]), 100
    points.each do |point|
      point.to_vertex(renderer)
    end
    end_shape CLOSE
    return if level.zero?
    branches.each(&:draw)
  end
end
