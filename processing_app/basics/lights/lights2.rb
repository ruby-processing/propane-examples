#!/usr/bin/env jruby
require 'propane'
require 'arcball'
# Lights 2
# by Simon Greenwold.
#
# Display a box with three different kinds of lights.
class Lights2 < Propane::App

  def setup
    sketch_title 'Lights 2'
    Processing::ArcBall.init(self)
    no_stroke
  end

  def draw
    background 0
    lights
    point_light 150, 100, 0, # color
    200, -150, 0             # position
    directional_light 0, 102, 255, # color
    1,   0,   0                    # x-, y-, z-axis direction
    spot_light 255, 255, 109, # color
    0,  40, 200, # position
    0,-0.5,-0.5, # direction
    PI / 2, 2    # angle, concentration
    box 150
  end

  def settings
    size 640, 360, P3D
  end
end

Lights2.new
