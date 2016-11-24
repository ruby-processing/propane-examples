#!/usr/bin/env jruby
require 'propane'
# Recursion.
#
# A demonstration of recursion, which means functions call themselves.
# Notice how the drawCircle() function calls itself at the end of its block.
# It continues to do this until the variable "level" is equal to 1.
class Recursion1 < Propane::App 

  def setup
    sketch_title 'Recursion 1'
    no_stroke
    no_loop
  end

  def draw
    draw_circle width / 2, 280, 6
  end

  def draw_circle ( x, radius, level )
    tt = 126 * level / 4.0
    fill tt
    ellipse x, height / 2, radius * 2, radius * 2
    return unless level > 1
    level = level - 1
    draw_circle x - radius / 2, radius / 2, level
    draw_circle x + radius / 2, radius / 2, level
  end

  def settings
    size 640, 360
  end
end

Recursion1.new
