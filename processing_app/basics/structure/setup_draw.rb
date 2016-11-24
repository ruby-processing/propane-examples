#!/usr/bin/env jruby
require 'propane'
# Settings, Setup and Draw.
# The settings() function is where you set size and drawing mode
# The setup() function is where you can do static stuff (called once)
# The draw() function creates a draw loop so you can write programs that
# change with time.
class SetupDraw < Propane::App

  def settings
    size 640, 360
  end

  def setup
    sketch_title 'Setup Draw'
    @y = 100
    stroke 255
    frame_rate 30
  end

  def draw
    background 0
    @y = @y - 1
    @y = height if @y < 0
    line 0, @y, width, @y
  end
end

SetupDraw.new
