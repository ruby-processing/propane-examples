#!/usr/bin/env jruby -v -W2
require 'propane'
# Load and Display a Shape.
# Illustration by George Brower.
#
# The loadShape() command is used to read simple SVG (Scalable Vector Graphics)
# files and OBJ (Object) files into a Processing sketch. This example loads an
# SVG file of a monster robot face and displays it to the screen.
#
class LoadDisplayShape < Propane::App
  attr_reader :bot

  def setup
    sketch_title 'Load and Display Shape'
    # The file 'bot1.svg' must be in the data folder
    # of the current sketch to load successfully
    @bot = load_shape(data_path('bot1.svg'))
  end

  def draw
    background(102)
    shape(bot, 280, 40) # Draw at coordinate (280, 40) at the default size
  end

  def settings
    size 640, 360
  end
end

LoadDisplayShape.new
