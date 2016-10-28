#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# PolarToCartesian
# by Daniel Shiffman.
#
# Convert a polar coordinate (r,theta) to cartesian (x,y):
# x = r * cos(theta)
# y = r * sin(theta)
class PolarToCartesian
  attr_reader :r, :theta

  def setup
    sketch_title 'Polar to Cartesian'
    frame_rate 30
    @r = height * 0.45
    @theta = 0.0
    @theta_vel = 0.0
    @theta_acc = 0.1e-3
  end

  def draw
    background 0
    translate width / 2, height / 2
    # Convert polar to cartesian
    x = r * Math.cos(theta)
    y = r * Math.sin(theta)
    ellipse_mode CENTER
    no_stroke
    fill 200
    ellipse x, y, 32, 32
    @theta_vel += @theta_acc
    @theta += @theta_vel
  end

  def settings
    size 640, 360
  end
end

PolarToCartesian.new
