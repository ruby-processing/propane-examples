#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

class Noise < Propane::App

  # by Martin Prout.
  # Using noise to create simple texture.
  # control parameter with mouse

  def setup
    sketch_title 'Noisy Texture'
    @increment = 0.02
  end

  def draw
    background 0
    load_pixels
    xoff = 0.0
    x_val = map1d(mouse_x, 0..width, 1..100)
    (0...width).each do |x|
      xoff += @increment
      yoff = 0.0
      (0...height).each do |y|
        yoff += @increment
        bright = noise(x / x_val, y / x_val) * 255
        pixels[x + y * width] = color(bright)
      end
    end
    update_pixels
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

Noise.new
