#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
require 'arcball'

############################
# Use mouse drag to rotate
# the arcball. Use mousewheel
# to zoom. Constrained to
# rotation around z-axis
############################
class Constrain < Propane::App

  def setup
    sketch_title 'Arcball Box'
    Processing::ArcBall.constrain self, :zaxis
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

Constrain.new
