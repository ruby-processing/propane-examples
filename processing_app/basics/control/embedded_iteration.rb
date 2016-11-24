#!/usr/bin/env jruby
require 'propane'
# Embedding "for" structures allows repetition in two dimensions.
class Embeded < Propane::App
  def setup
    sketch_title 'Embeded Iteration'
    background 0
    no_stroke
    box_size = 11.0
    box_space = 12.0
    margin = 7
    # Draw gray boxes
    (margin...height-margin).step(box_space) do |i|
      # or, if you feel more java-loopy:
      # i = margin; while i < height-margin
      if box_size > 0
        (margin...width-margin).step(box_space) do |j|
          fill( 255 - box_size * 10 )
          rect j, i, box_size, box_size
        end
      end
      box_size -= 0.3
      # for java loops, don't forget to increment with while:
      # i += box_space
    end
  end

  def settings
    size 640, 360
  end
end

Embeded.new
