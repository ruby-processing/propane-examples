#!/usr/bin/env jruby
require 'propane'
require 'geomerative'

# Original by Edward Loveall, converted to propane by Martin Prout
# Click in frame to start the line (repeat as required to generate path)
# Makes use of propane Vec2D class
class GeomerativePath < Propane::App
  include_package 'geomerative'

  attr_reader :shp1, :oldvec, :stp

  def settings
    size(400, 400)
  end

  def setup
    sketch_title 'Geomerative Path'
    background(0)
    @stp = 0
    RG.init(self)
    @oldvec = Vec2D.new(width / 4, height / 2)
    start = RPoint.new(oldvec.x, oldvec.y)
    @shp1 = RPath.new(start)
  end

  def draw
    background(0)
    stroke(255)
    stroke_weight(3)
    no_fill
    translate(stp, 0) # advance line along x axis by stp
    shp1.draw
    @stp -= 1
  end

  def mouse_pressed
    distvec = Vec2D.new(mouse_x, mouse_y) - oldvec
    vec_one = Vec2D.new(oldvec.x + (distvec.x * 0.25).to_i - stp, oldvec.y)
    vec_two = Vec2D.new(oldvec.x - (distvec.x * 0.25).to_i - stp, mouse_y)
    vec_three = Vec2D.new(mouse_x - stp, mouse_y)
    add_bezier(vec_one, vec_two, vec_three)
    @oldvec = Vec2D.new(mouse_x, mouse_y)
  end

  private

  def add_bezier(a, b, c)
    shp1.add_bezier_to(a.x, a.y, b.x, b.y, c.x, c.y)
  end
end

GeomerativePath.new
