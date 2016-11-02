#!/usr/bin/env jruby -w
require 'propane'

Move the pointer left and right across the image to change
#  its position. This program overlays one image over another
#  by modifying the alpha value of the image with the tint() function.
class Transparency < Propane::App

  def setup
    sketch_title 'Transparency'
    @a = load_image(data_path('construct.jpg'))
    @b = load_image(data_path('wash.jpg'))
    @offset = 0.0
  end

  def draw
    image @a, 0, 0
    offset_target = map1d(mouse_x,(0..width), (-@b.width / 2 - width / 2..0))
    @offset += (offset_target - @offset) * 0.05
    tint 255, 153
    image @b, @offset, 20
  end

  def settings
    size 200, 200
  end
end

Transparency
