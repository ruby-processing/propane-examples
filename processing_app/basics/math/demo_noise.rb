#!/usr/bin/env jruby
require 'propane'

class DemoNoise < Propane::App
  attr_reader :z, :smth

  def setup
    sketch_title 'Demo noise_mode'
    stroke(255, 64)
    @z = 0
    @smth = false
  end

  def draw
    noise_scale = 0.01
    background(0)
    grid(width, height, 10, 10) do |x, y|
      if smth
        arrow(x, y, SmoothNoise.noise(x * noise_scale, y * noise_scale, z * noise_scale) * TAU)
      else
        arrow(x, y, noise(x * noise_scale, y * noise_scale, z * noise_scale) * TAU)
      end
    end
    @z += 1
  end

  def mouse_pressed
    @smth = !smth
  end

  def arrow(x, y, ang)
    push_matrix
    translate(x, y)
    rotate(ang)
    line(0, 0, 20, 0)
    translate(20, 0)
    rotate(PI + 0.4)
    line(0, 0, 5, 0)
    rotate(-0.8)
    line(0, 0, 5, 0)
    pop_matrix
  end

  def settings
    size(600, 400, P2D)
  end
end

DemoNoise.new
