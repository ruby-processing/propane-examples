#!/usr/bin/env jruby
require 'propane'
# Rotate 1.
#
# Rotating simultaneously in the X and Y axis.
# Transformation functions such as rotate() are additive.
# Successively calling rotate(1.0) and rotate(2.0)
# is equivalent to calling rotate(3.0).
class Rotate1 < Propane::App

  def setup
    sketch_title 'Rotate 2'
    @r_size = width / 6.0
    @a = 0.0
    no_stroke
    fill 204, 204
  end

  def draw
    background 0
    @a += 0.005
    @a = 0.0 if @a > TAU
    translate width / 2, height / 2
    rotate_x @a
    rotate_y @a * 2
    rect(-@r_size, -@r_size, @r_size * 2, @r_size * 2)
    rotate_x @a * 1.001
    rotate_y @a * 2.002
    rect(-@r_size, -@r_size, @r_size * 2, @r_size   )
  end

  def settings
    size 640, 360, P3D
  end
end

Rotate1.new
