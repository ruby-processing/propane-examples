#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Sine Cosine.
#
# Linear movement with sin() and cos().
# Numbers between 0 and PI*2 (TAU which angles roughly 6.28)
# are put into these functions and numbers between -1 and 1 are
# returned. These values are then scaled to produce larger movements.
# note only angle1 angle2 need scope outside draw loop
#
class SineCosine < Propane::App
  attr_reader :angle1, :angle2
  SCALAR = 70

  def setup
    sketch_title 'Sine Cosine'
    no_stroke
    rect_mode(CENTER)
    @angle1 = 0
    @angle2 = 0
  end

  def draw
    background(0)
    ang1 = angle1.radians
    ang2 = angle2.radians
    x1 = width / 2 + (SCALAR * Math.cos(ang1))
    x2 = width / 2 + (SCALAR * Math.cos(ang2))
    y1 = height / 2 + (SCALAR * Math.sin(ang1))
    y2 = height / 2 + (SCALAR * Math.sin(ang2))
    fill(255)
    rect(width * 0.5, height * 0.5, 140, 140)
    fill(0, 102, 153)
    ellipse(x1, height * 0.5 - 120, SCALAR, SCALAR)
    ellipse(x2, height * 0.5 + 120, SCALAR, SCALAR)
    fill(255, 204, 0)
    ellipse(width * 0.5 - 120, y1, SCALAR, SCALAR)
    ellipse(width * 0.5 + 120, y2, SCALAR, SCALAR)
    @angle1 += 2
    @angle2 += 3
  end

  def settings
    size(640, 360)
  end
end

SineCosine.new
