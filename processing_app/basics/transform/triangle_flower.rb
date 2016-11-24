#!/usr/bin/env jruby
require 'propane'
# Triangle Flower
# by Ira Greenberg.
#
# Using rotate() and triangle() functions generate a pretty
# flower. Uncomment the line "# rotate(rot+=spin.radians);"
# in the triBlur() function for a nice variation.
class TriangleFlower < Propane::App
  attr_reader :pt, :shift, :spin, :fade

  def setup
    sketch_title 'Triangle Flower'
    background 0
    @fill_color = 0.0
    @shift = 1.0
    @rot = 0.0
    @fade = 255.0 / (width / 2.0 / shift)
    @spin = 360.0 / (width / 2.0 / shift)
    @pt = []
    pt << Point.new(-width / 2.0, height / 2.0)
    pt << Point.new(width / 2.0, height / 2.0)
    pt << Point.new(0.0, -height / 2.0)
    no_stroke
    translate width / 2, height / 2
    tri_blur while pt[0].x < 0
  end

  def tri_blur
    fill @fill_color
    @fill_color += fade
    rotate spin
    # try these lines also ..
    # @rot += spin.radians
    # rotate @rot
    pt[0].x += shift
    pt[0].y -= shift / 2
    pt[1].x -= shift
    pt[1].y -= shift / 2
    pt[2].y += shift
    triangle pt[0].x, pt[0].y, pt[1].x, pt[1].y, pt[2].x, pt[2].y
  end

  # Point Struct
  Point = Struct.new(:x, :y)

  def settings
    size 200, 200
  end
end

TriangleFlower.new
