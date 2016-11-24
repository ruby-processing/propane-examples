#!/usr/bin/env jruby
require 'propane'
# TRIANGLE_STRIP Mode
# by Ira Greenberg.
#
# Generate a closed ring using vertex()
# function and begin_shape(TRIANGLE_STRIP) mode
# using outer_radius and inner_radius variables to
# control ring's outer/inner radii respectively.
# Trig functions generate ring.
class TriangleStrip < Propane::App

  attr_reader :x, :y, :outer_radius, :inner_radius

  def setup
    sketch_title 'Triangle Strip'
    @x = width / 2
    @y = height / 2
    @outer_radius = [width, height].min * 0.4
    @inner_radius = outer_radius * 0.6
  end

  def draw
    background 204
    pts = map1d(mouse_x, (0..width), (6..60)).to_i
    angle = 0      # degrees
    step = 180 / pts # degrees
    begin_shape TRIANGLE_STRIP
    (0..pts).each do
      px = x + DegLut.cos(angle) * outer_radius
      py = y + DegLut.sin(angle) * outer_radius
      angle += step
      vertex px, py
      px = x + DegLut.cos(angle) * inner_radius
      py = y + DegLut.sin(angle) * inner_radius
      angle += step
      vertex px, py
    end
    end_shape
  end

  def settings
    size 640, 360
  end
end

TriangleStrip.new
