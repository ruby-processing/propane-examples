#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Linear Interpolation.
#
# Move the mouse across the screen and the symbol will follow.
# Between drawing each frame of the animation, the ellipse moves
# part of the distance (0.05) from its current position toward
# the cursor using the lerp() function
#
# This is the same as the Easing under input only with lerp() instead.
#
class Interpolation < Propane::App
attr_reader :x, :y

def setup
  sketch_title 'Interpolate'
  @x, @y = 0, 0
  no_stroke
end

def draw
  background(51)
  # lerp() calculates a number between two numbers at a specific increment.
  # The amt parameter is the amount to interpolate between the two values
  # where 0.0 equal to the first point, 0.1 is very near the first point, 0.5
  # is half-way in between, etc.
  # Here we are moving 5% of the way to the mouse location each frame
  @x = lerp(x, mouse_x, 0.05)
  @y = lerp(y, mouse_y, 0.05)
  fill(255)
  stroke(255)
  ellipse(x, y, 66, 66)
end

def settings
  size(640, 360)
end
end

Interpolation.new
