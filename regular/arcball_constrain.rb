#!/usr/bin//env jruby -v -w

require 'propane'
require 'arcball'

############################
# Use mouse drag to rotate
# the arcball. Use mousewheel
# to zoom. Custom constrain
# default is yaxis.
############################

class ArcballBox < Propane::App

  def settings
    size(600, 600, P3D)
    smooth(8)
  end

  def setup
    sketch_title 'ArcBall Box'
    Processing::ArcBall.constrain(self, :xaxis)
    fill 180
  end

  def draw
    background(50)
    box(300, 300, 300)
  end
end

ArcballBox.new
