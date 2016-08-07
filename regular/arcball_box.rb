#!/usr/bin/env jruby -v -w
require 'arcball'
require 'propane'

############################
# Use mouse drag to rotate
# The arcball. Use mousewheel
# to zoom. Hold down x, y, z
# to constrain rotation axis.
############################

class ArcballBox < Propane::App

  def setup
    size(600, 600, P3D)
    smooth(8)
  end

  def setup
    sketch_title 'ArcBall Box'
    ArcBall.init(self, 300, 300)
    fill 180
  end

  def draw
    background(50)
    box(300, 300, 300)
  end
end

ArcballBox.new
