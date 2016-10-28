#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
class SineWave < Propane::App
  # Sine Wave
  # by Daniel Shiffman.
  #
  # Render a simple sine wave.
  def setup
    sketch_title 'Sine Wave'
    frame_rate 30
    color_mode RGB, 255, 255, 255, 100
    @w = width + 16
    @period = 500.0
    @x_spacing = 8
    @dx = (TAU / @period) * @x_spacing
    @y_values = []
    @theta = 0.0
    @amplitude = 75.0
  end

  def draw
    background 0
    calc_wave
    draw_wave
  end

  def calc_wave
    @theta += 0.02
    x = @theta
    (0...(@w / @x_spacing)).each do |i|
      @y_values[i] = Math.sin(x) * @amplitude
      x += @dx
    end
  end

  def draw_wave
    no_stroke
    fill 255, 50
    ellipse_mode CENTER
    @y_values.each_with_index do |v, x|
      ellipse x*@x_spacing, height / 2 + v, 16, 16
    end
  end

  def settings
    size 640, 360
  end
end

SineWave.new
