#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true

require_relative 'propane'
# Demo of Mouse Button
class MouseButtonDemo < Propane::App
  # Click within the image and press
  # the left and right mouse buttons to
  # change the value of the rectangle
  def setup
    size 300, 200
  end

  def draw
    rect(25, 25, 150, 80)
  end

  def mouse_pressed
    case mouse_button
    when LEFT
      fill 0
    when RIGHT
      fill 255
    when CENTER
      fill 125
    else
      fill 200, 0, 0
    end
  end
end

MouseButtonDemo.new title: 'Mouse Button Demo'
