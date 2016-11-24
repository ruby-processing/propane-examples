#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'
# example of processing blend_color (uses PImage blend_color under the hood)
# blend_color(c1, c2, MODE) returns a color int
class BlendColor < Propane::App
  attr_reader :blue, :orange, :orangeblueadd

  def setup
    sketch_title 'blend'
    @orange = color(204, 102, 0)
    @blue = color(0, 102, 153)
    @orangeblueadd = blend_color(orange, blue, ADD)
  end

  def draw
    background(51)
    no_stroke
    fill(orange)
    rect(14, 20, 20, 60)
    fill(orangeblueadd)
    rect(40, 20, 20, 60)
    fill(blue)
    rect(66, 20, 20, 60)
  end

  def settings
    size 100, 100, FX2D
  end
end

BlendColor.new
