#!/usr/bin/env jruby
require 'propane'
# The first two parameters for the bezier function specify the
# first point in the curve and the last two parameters specify
# the last point. The middle parameters set the control points
# that define the shape of the curve.
class Bezier < Propane::App

  def setup
    sketch_title 'Bezier'
    stroke 255
    no_fill
  end

  def draw
    background 0
    (0..200).step(20) do |i|
      bezier(
        mouse_x - (i / 2.0),
        40 + i,
        410,
        20,
        440,
        300,
        240 - (i / 66.0),
        300 + (i / 8.0)
      )
    end
  end

  def settings
    size 640, 360
  end
end

Bezier.new
