#!/usr/bin/env jruby -v -w
# frozen_string_literal: true

require 'propane'

class VeraMolnar < Propane::App
  # Creative Coding
  # # # # #
  # Vera Molnar – 25 Squares
  # # # # #
  # Interpretation by Martin Vögeli
  # Converted to JRubyArt Martin Prout
  # # # # #
  # Based on code by Indae Hwang and Jon McCormack
  #
  
  def settings
    size(600, 600)
  end
  
  def setup
    sketch_title '25 Squares'
    rect_mode(CORNER)
    no_stroke
    frame_rate(1)  # set the frame rate to 1 draw call per second
  end
  
  def draw
    background(180) # clear the screen to grey
    grid_size = 5 # rand(3..12)   # select a rand number of squares each frame
    gap = 5 # rand(5..50) # select a rand gap between each square
    # calculate the size of each square for the given number of squares and gap between them
    cellsize = (width - (grid_size + 1) * gap) / grid_size
    # calculate shadow offset
    offset_x = cellsize / 16.0
    offset_y = cellsize / 16.0
    grid_size.times do |i|
      grid_size.times do |j|
        # fill(140, 180) # shadow
        # rect(gap * (i + 1) + cellsize * i + offset_x, gap * (j + 1) + cellsize * j + offset_y, cellsize, cellsize)
        if rand(0..5) > 4
          fill(color('#a11220'), 180.0) # Note how to create transparent fill with web color JRubyArt
        else
          fill(color('#884444'), 180.0) 
        end
        rect(gap * (i + 1) + cellsize * i + rand(-5..5), gap * (j + 1) + cellsize * j + rand(-5..5), cellsize, cellsize)
      end
    end
    # save your drawings when you press keyboard 's' continually
    if (key_pressed? && key == 's')
      save_frame('######.jpg')
    end
  end #end of draw
end # class

VeraMolnar.new
