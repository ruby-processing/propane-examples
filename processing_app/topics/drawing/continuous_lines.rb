#!/usr/bin/env jruby
require 'propane'
# Continuous Lines.
#
# Click and drag the mouse to draw a line.
class ContinuousLines < Propane::App
  def setup
    sketch_title 'Continuous Lines'
    background(102)
  end

  def draw
    stroke(255)
    if mouse_pressed?
      line(mouse_x, mouse_y, pmouse_x, pmouse_y)
    end
  end

  def settings
    size(640, 360)
  end
end

ContinuousLines.new
