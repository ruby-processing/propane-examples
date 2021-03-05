#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Noise3D.
#
# Using 3D noise to create simple animated texture.
# Here, the third dimension ('z') is treated as time.
# Press mouse to switch Noise Implementions.
class Noise3D < Propane::App
  attr_reader :increment, :z_increment

  def setup
    sketch_title 'Noise 3D'
    frame_rate 30
    @increment = 0.01
    @zoff = 0.0
    @z_increment = 0.02
  end

  def draw
    background 0
    load_pixels
    xoff = 0.0
    (0...width).each do |x|
      xoff += increment
      yoff = 0.0
      (0...height).each do |y|
        yoff += increment
        bright = noise(xoff, yoff, @zoff) * 255
        pixels[x + y * width] = color(bright, bright, bright)
      end
    end
    update_pixels
    @zoff += z_increment
  end

  def mouse_pressed
    mode = Propane::SIMPLEX
    noise_mode mode
    sketch_title "#{mode}"
  end

  def mouse_released
    mode = Propane::VALUE
    noise_mode(mode)
    sketch_title "#{mode}"
  end

  def settings
    size 640, 360
  end
end

Noise3D.new
