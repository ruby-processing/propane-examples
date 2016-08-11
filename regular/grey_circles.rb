#!/usr/bin/env jruby -v -w
# frozen_string_literal: true
# grey circles : borrowed from https://github.com/quil/quil
require 'propane'

class GreyCircles < Propane::App
  
  def setup
    size(323, 200)
    smooth
  end
 
  def setup
    sketch_title 'Oh so many circles'
    frame_rate(1)
    background(200)
  end

  def draw
    stroke_setup
    diameter = rand(100)
    ellipse(rand(width), rand(height), diameter, diameter)
  end

  def stroke_setup
    [:stroke, :stroke_weight, :fill].each do |method|
      send(method, rand(255))
    end
  end
end

GreyCircles.new
