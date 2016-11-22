#!/usr/bin/env jruby
require 'propane'

class Orbit < Propane::App
  # Ported from http://nodebox.net/code/index.php/Graphics_State

  # This sketch demonstrates how to use the frame rate as orbital state,
  # as well as how to use system fonts in Ruby-Processing.
  attr_reader :d_font

  def setup
    sketch_title 'Orbit'
    frame_rate 30
    fill 0
    @d_font = create_font('Helvetica', 40)
  end

  def draw
    background 255
    translate 225, 225
    text_font d_font
    ellipse 0, 0, 10, 10
    text 'sun', 10, 0
    3.times do |i|
      push_matrix
      rotate frame_count / -180.0 * PI + i * PI / -1.5
      line 0, 0, 120, 0
      translate 120, 0
      ellipse 0, 0, 10, 10
      text_font d_font, 22
      text 'planet', 10, 0
      rotate frame_count / -30.0 * PI
      line 0, 0, 30, 0
      text_font d_font, 15
      text 'moon', 32, 0
      pop_matrix
    end
  end

  def settings
    size 450, 450
    smooth
  end
end

Orbit.new
