#!/usr/bin/env jruby
require 'propane'
require 'geomerative'

class BinaryIntersection < Propane::App
  include_package 'geomerative'
  attr_reader :shp1, :shp2, :shp3, :cursor_shape

  def setup
    sketch_title 'Binary Intersection'
    RG.init(self)
    @shp1 = RShape.create_ring(0, 0, 120, 50)
    @shp2 = RShape.create_star(0, 0, 100.0, 80.0, 20)
  end

  def draw
    background(255)
    translate(width / 2, height / 2)
    @cursor_shape = RShape.new(shp2)
    cursor_shape.translate(mouse_x - width / 2, mouse_y - height / 2)
    # Only intersection does not work for shapes with more than one path
    @shp3 = RG.diff(shp1, cursor_shape)
    stroke_weight 3
    if mouse_pressed?
      fill(220, 0, 0, 30)
      stroke(120, 0, 0)
      RG.shape(cursor_shape)
      fill(0, 220, 0, 30)
      stroke(0, 120, 0)
      RG.shape(shp1)
    else
      fill(220)
      stroke(120)
      RG.shape(shp3)
    end
  end

  def settings
    size(400, 400)
    smooth
  end
end

BinaryIntersection.new
