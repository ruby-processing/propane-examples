#!/usr/bin/env jruby
require 'propane'
# Reflection
# by Simon Greenwold.
#
# Vary the specular reflection component of a material
# with the horizontal position of the mouse.
class Reflection < Propane::App

  def setup
    sketch_title 'Reflection'
    no_stroke
    color_mode RGB, 1
    fill 0.4
  end

  def draw
    background 0
    translate width / 2, height / 2
    light_specular 1, 1, 1
    directional_light 0.8, 0.8, 0.8, 0, 0, -1
    s = mouse_x / width.to_f
    specular s
    sphere 120
  end

  def settings
    size 640, 360, P3D
  end
end

Reflection.new
