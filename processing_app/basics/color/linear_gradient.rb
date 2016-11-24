#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'
# Simple Linear Gradient
#
# The lerp_color function is useful for interpolating
# between two colors.
class LinearGradient < Propane::App
  Y_AXIS = 1
  X_AXIS = 2

  attr_reader :b1, :b2, :c1, :c2

  def setup
    sketch_title 'Linear Gradient'
    # Define colors
    @b1 = color(255)
    @b2 = color(0)
    @c1 = color(204, 102, 0)
    @c2 = color(0, 102, 153)
  end

  def draw
    # Background
    set_gradient(0, 0, width / 2, height, b1, b2, X_AXIS)
    set_gradient(width / 2, 0, width / 2, height, b2, b1, X_AXIS)
    # Foreground
    set_gradient(50, 90, 540, 80, c1, c2, Y_AXIS)
    set_gradient(50, 190, 540, 80, c2, c1, X_AXIS)
  end

  def set_gradient(x, y, w, h, c1, c2, axis)
    no_fill
    if (axis == Y_AXIS) # Top to bottom gradient
      (y...y + h).each do |i|
        inter = norm(i, y, y + h)
        stroke lerp_color(c1, c2, inter)
        line(x, i, x + w, i)
      end
    elsif (axis == X_AXIS) # Left to right gradient
      (x...x + w).each do |i|
        inter = norm(i, x, x + w)
        stroke lerp_color(c1, c2, inter)
        line(i, y, i, y + h)
      end
    end
  end

  def settings
    size 640, 360
  end
end

LinearGradient.new
