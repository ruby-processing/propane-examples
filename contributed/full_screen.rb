#!/usr/bin/env jruby
require 'propane'
# Description:
# This is a full-screen demo
class FullScreen < Propane::App
  def setup
    sketch_title 'Full Screen'
    no_stroke
  end

  def draw
    lights
    background 0
    fill 120, 160, 220
    grid(width, height, 100, 100) do |x, y|
      push_matrix
      translate x + 50, y + 50
      rotate_y(((mouse_x.to_f + x) / width) * PI)
      rotate_x(((mouse_y.to_f + y) / height) * PI)
      box 90
      pop_matrix
    end
  end

  def settings
    full_screen P3D
  end
end

FullScreen .new
