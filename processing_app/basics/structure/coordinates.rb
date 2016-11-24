#!/usr/bin/env jruby
require 'propane'

class Coordinates < Propane::App


  def setup
    sketch_title 'Coordinates'
    # Sets the screen to be 640, 360, so the width of the window is 640 pixels
    # and the height of the window is 360 pixels
    background 0
    no_fill
    stroke_weight 2
    stroke 255
    # The two parameters of the point() method each specify coordinates.
    # This call to point() draws at the position [320, 180]
    point width / 2, height / 2
    # Draws to the position [320, 80]
    point width / 2, height / 4
    # Coordinates are used for drawing all shapes, not just points.
    # Parameters for different methods are used for different purposes.
    # For example, the first two parameters to line() specify the coordinates of the
    # first point and the second two parameters specify the second point
    stroke color(0, 153, 255)
    line(0, height * 0.33, width, height * 0.33)
    # The first two parameters to rect() are coordinates
    # and the second two are the width and height
    stroke color(255, 153, 0)
    rect(width*0.25, height * 0.1, width * 0.5, height * 0.8)
  end

  def settings
    size 640, 360
  end
end

Coordinates.new
