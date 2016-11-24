#!/usr/bin/env jruby
require 'propane'
# The basic shape primitive functions are triangle, rect,
# quad, and ellipse. Squares are made with rect and circles
# are made with ellipse. Each of these functions requires a number
class ShapePrimitives < Propane::App

  def setup
    sketch_title 'Shape Primitives'
    background 0
    no_stroke
    fill 204
    triangle 18, 18, 18, 360, 81, 360
    fill 102
    rect 81, 81, 63, 63
    fill 204
    quad 189, 18, 216, 18, 216, 360, 144, 360
    fill 255
    ellipse 252, 144, 72, 72
    fill 204
    triangle 288, 18, 351, 360, 288, 360
    fill(255)
    arc(479, 300, 280, 280, PI, TAU)
  end

  def settings
    size 640, 360
    smooth 4
  end
end

ShapePrimitives.new
