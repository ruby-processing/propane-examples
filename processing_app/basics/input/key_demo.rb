#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Demo of Mouse Button
class MouseButtonDemo < Propane::App
  # Click within the image and press
  # the left and right mouse buttons to
  # change the value of the rectangle

  def settings
    size 300, 200
  end

  def setup
    sketch_title 'Mouse Button Demo'
  end

  def draw
    rect(25, 25, 150, 80)
  end

  def key_pressed
    case key
    when 'c', 'C'
      fill 0
    when 'b', 'B'
      fill 255
    when 'c', 'C'
      fill 125
    else
      fill 200, 0, 0
    end
  end
end

MouseButtonDemo.new
