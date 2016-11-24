#!/usr/bin/env jruby
require 'propane'
# Redraw.
#
# The redraw() function makes draw() execute once.
# In this example, draw() is executed once every time
# the mouse is clicked.
class Redraw < Propane::App

  def setup
    sketch_title 'Redraw'
    @y = 100
    stroke 255
    no_loop
  end

  def draw
    background 0
    @y = mouse_y if (2...height).cover? mouse_y
    line 0, @y, width, @y
  end

  def key_pressed
    redraw
  end

  def settings
    size 200, 200
  end
end

Redraw.new
