#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Noise Wave
# after Daniel Shiffman.
#
# Press mouse to switch Noise Implementions
class NoiseWave < Propane::App

attr_reader :yoff         # 2nd dimension of perlin noise

def setup
  sketch_title 'Noise Wave'
  @yoff = 0.0
end

def draw
  background(51)
  fill(255)
  # We are going to draw a polygon out of the wave points
  begin_shape
  xoff = 0       # Option #1: 2D Noise
  # xoff = yoff # Option #2: 1D Noise
  # Iterate over horizontal pixels
  (0..width).step(10) do |x|
    # Calculate a y value according to noise, map to
    y = map1d(noise(xoff, yoff), (0..1.0), (200..300)) # Option #1: 2D Noise
    # y = map1d(noise(xoff), (0..1.0), (200..300))    # Option #2: 1D Noise
    # Set the vertex
    vertex(x, y)
    # Increment x dimension for noise
    xoff += 0.05
  end
  # increment y dimension for noise
  @yoff += 0.01
  vertex(width, height)
  vertex(0, height)
  end_shape(CLOSE)
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
  size(640, 360)
end
end

NoiseWave.new
