#!/usr/bin/env jruby
# frozen_string_literal: true

require 'propane'

class Koch < Propane::App
  load_library :koch

  def setup
    sketch_title 'Koch'
    background(255)
    frame_rate(1) # Animate slowly
    @k = KochFractal.new(width, height)
  end

  def draw
    background(255)
    # Draws the snowflake!
    @k.render
    # Iterate
    @k.next_level
    # Let's not do it more than 5 times. . .
    @k.restart if @k.count > 5
  end

  def settings
    size(800, 250)
    smooth 8
  end
end

Koch.new
