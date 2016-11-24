#!/usr/bin/env jruby
require 'propane'

class Spot < Propane::App
  # Spot.
  #
  # Move the mouse the change the position and concentation
  # of a blue spot light.

  def setup
    sketch_title 'Spot'
    @concentration = 600 # try values between 1 <-> 10_000
    no_stroke
    fill 204
    sphere_detail 60
  end

  def draw
    background 0
    directional_light 51, 102, 126, 0, -1, 0
    spot_light 204, 153, 0, 360, 160, 600, 0, 0, -1, PI / 2, @concentration
    spot_light 102, 153, 204, 360, mouse_y, 600, 0, 0, -1, PI / 2, @concentration
    translate width / 2, height / 2
    sphere 120
  end

  def settings
    size 640, 360, P3D
    smooth(8)
  end
end

Spot.new
