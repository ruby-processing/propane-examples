#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
require 'arcball'
# The current local time can be read with the Time.now
# the seconds Time.now.sec, minutes Time.now.min etc...
# functions. In this example, DegLut.sin() and DegLut.cos() values are used to
# set the position of the hands, perfect for degree precision Lookup Table.
class ArcBallBox < Propane::App
  ############################
  # Use mouse drag to rotate
  # the arcball. Use mousewheel
  # to zoom. Hold down x, y, z
  # to constrain rotation axis.
  ############################
  def setup
    sketch_title 'Arcball Box'
    Processing::ArcBall.init self, 300, 300
    fill 180
  end

  def draw
    background 50
    box 300, 300, 300
  end

  def settings
    size 600, 600, P3D
    smooth 8
  end
end

ArcBallBox.new
