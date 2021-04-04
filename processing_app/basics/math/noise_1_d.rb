#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

class Noise1D < Propane::App
  attr_reader :smth

  def setup
    sketch_title 'Noise 1D'
    @xoff = width / 2
    @x_increment = 0.01
    background 0
    no_stroke
    @smth = false
  end

  def draw
    fill 0, 10
    rect 0, 0, width, height
    n = smth ? SmoothNoise.noise(@xoff) * width : noise(@xoff) * width
    @xoff += @x_increment
    fill 200
    ellipse n, height / 2, 64, 64
  end

  def mouse_pressed
    @smth = !smth
  end

  def settings
    size 640, 360
  end
end

Noise1D.new
