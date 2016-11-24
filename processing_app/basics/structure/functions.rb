#!/usr/bin/env jruby
require 'propane'
# Functions.
#
# The drawTarget() function makes it easy to draw many distinct targets.
# rings for each target.
class Functions < Propane::App

  def setup
    sketch_title 'Functions'
    no_stroke
    no_loop
  end

  def draw
    background 51
    draw_target width * 0.25, height * 0.4, 200, 4
    draw_target width * 0.50, height * 0.5, 300, 10
    draw_target width * 0.75, height * 0.3,  120, 6
  end

  def draw_target (x, y, size, num)
    greys = 255 / num
    steps = size / num
    (0...num).each do |i|
      fill color(greys * i)
      ellipse x, y, size - i * steps, size - i * steps
    end
  end

  def settings
    size 640, 360
  end
end

Functions.new
