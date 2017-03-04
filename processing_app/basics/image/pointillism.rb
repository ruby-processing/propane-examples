##!/usr/bin/env jruby -w
require 'propane'
# Pointillism
# by Daniel Shiffman.
#
# Creates a simple pointillist effect using ellipses colored
# according to pixels in an image.
class Pointillism < Propane::App
  def setup
    sketch_title 'Pointillism'
    @a = load_image(data_path('eames.jpg'))
    no_stroke
    background 255
  end

  def draw
    pointillize = map1d(mouse_x, 0..width, 2..18)
    x, y = rand(@a.width), rand(@a.height)
    pixel = @a.get(x, y)
    fill pixel, 126
    ellipse x * 2, y * 2, pointillize, pointillize
  end

  def settings
    size 400, 400
  end
end

Pointillism.new
