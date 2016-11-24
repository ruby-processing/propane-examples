#!/usr/bin/env jruby
require 'propane'

class Noloop < Propane::App
  # No Loop.
  #
  # The noLoop() function causes draw() to only
  # execute once. Without calling noLoop(), draw()
  # executed continually.
  attr_reader :y

  def setup
    sketch_title 'No Loop'
    @y = height / 2
    stroke 255
    frame_rate 30
    no_loop
  end

  def draw
    background 0
    @y = y - 1
    @y = height if y < 0
    line 0, y, width, y
  end

  def settings
    size 640, 360
  end
end

Noloop.new
