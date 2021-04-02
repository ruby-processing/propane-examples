#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

class Noise < Propane::App

  # by Martin Prout.
  # Using noise to create simple texture.
  # control parameter with mouse
  attr_reader :smth

  def setup
    sketch_title 'Noisy Texture'
    @increment = 0.02
    @smth = false
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
        noise_val = smth ? SmoothNoise.noise(x / x_val, y / x_val) : noise(x / x_val, y / x_val)
        bright = (noise_val + 1) * 125
        pixels[x + y * width] = color(bright)
      end
    end
    update_pixels
  end

  def key_pressed
    return unless key == 's'

    @smth = !smth
  end

  def settings
    size 640, 360
  end
end

Noise.new
