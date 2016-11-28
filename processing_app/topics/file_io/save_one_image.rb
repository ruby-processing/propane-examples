#!/usr/bin/env jruby
require 'propane'
# Save One Image
#
# The save function allows you to save an image from the
# display window. In this example, save is run when a mouse
# button is pressed. The image 'line.tif' is saved to the
# same folder as the sketch's program file.
class SaveOneImage < Propane::App  
  def setup
    sketch_title 'Save One Image'
  end

  def draw
    background(204)
    line(0, 0, mouse_x, height)
    line(width, 0, 0, mouse_y)
  end

  def settings
    size(200, 200)
  end

  def mouse_pressed
    save(data_path('line.tif'))
  end
end

SaveOneImage.new
