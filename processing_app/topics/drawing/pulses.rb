#!/usr/bin/env jruby
require 'propane'
# Pulses.
#
# Software drawing instruments can follow a rhythm or abide by rules independent
# of drawn gestures. This is a form of collaborative drawing in which the draftsperson
# controls some aspects of the image and the software controls others.
class Pulses < Propane::App
  attr_reader :angle

  def setup
    sketch_title 'Pulses'
    background(102)
    noStroke
    fill(0, 102)
    @angle = 0
  end

  def draw
    # Draw only when mouse is pressed
    if mouse_pressed?
      @angle += 5
      val = cos(angle.radians) * 12.0
      (0 ... 360).step(75) do |a|
        xoff = cos(a.radians) * val
        yoff = sin(a.radians) * val
        fill(0)
        ellipse(mouse_x + xoff, mouse_y + yoff, val, val)
      end
      fill(255)
      ellipse(mouse_x, mouse_y, 2, 2)
    end
  end

  def settings
    size(640, 360)
  end
end

Pulses.new
