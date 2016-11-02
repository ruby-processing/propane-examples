#!/usr/bin/env jruby -v -W2
require 'propane'
# Scale Shape.
# Illustration by George Brower.
#
# Move the mouse left and right to zoom the SVG file.
# This shows how, unlike an imported image, the lines
class ScaleShape < Propane::App
  attr_reader :bot

  def settings
    size(640, 360)
  end

  def setup
    sketch_title 'Scale Shape'
    # The file 'bot1.svg' must be in the data folder
    # of the current sketch to load successfully
    @bot = load_shape(data_path('bot1.svg'))
  end

  def draw
    background(102)
    translate(width/2, height/2)
    zoom = map1d(mouse_x, (0..width), (0.1..4.5))
    scale(zoom)
    shape(bot, -140, -140)
  end
end

 ScaleShape.new
