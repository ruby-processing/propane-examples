#!/usr/bin/env jruby
require 'propane'
# PathPShape
#
# A simple path using PShape
class PathPshape < Propane::App
  # A PShape object
  attr_reader :path

  def setup
    sketch_title 'Path Pshape'
    # Create the shape
    @path = create_shape
    path.begin_shape
    # Set fill and stroke
    path.noFill
    path.stroke(255)
    path.stroke_weight(2)
    x = 0
    # Calculate the path as a sine wave
    (0..TAU).step(0.1) do |theta|
      path.vertex(x, sin(theta) * 100)
      x += 5
    end
    # The path is complete
    path.end_shape
  end

  def draw
    background(51)
    # Draw the path at the mouse location
    translate(mouse_x, mouse_y)
    shape(path)
  end

  def settings
    size(640, 360, P2D)
    smooth
  end
end

PathPshape.new
