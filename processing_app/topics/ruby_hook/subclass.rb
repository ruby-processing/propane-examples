#!/usr/bin/env jruby
require 'propane'

class SubClassSketch < Propane::App

  def setup
    sketch_title 'Subclass with a Hook'
    @arm = SpinArm.new(x: width / 2, y: height / 2, s: 0.01)
    @spots = SpinSpots.new(x: width / 2, y: height / 2, s: -0.02, d: 90.0)
  end

  def draw
    background 204
    @arm.display
    @spots.display
  end

  def settings
    size 640, 360
  end
end

class Spin
  include Propane::Proxy
  attr_accessor :x, :y, :speed
  attr_accessor :angle

  def initialize(args = {})
    @x, @y = args.fetch(:x, 0), args.fetch(:y, 0)
    @speed = args.fetch(:s, 0.1)
    @angle = args.fetch(:angle, 0.0)
    post_initialize(args)  # this is the hook
  end

  def update
    @angle += speed
  end

  def post_initialize(_args)
    nil
  end
end

class SpinArm < Spin # inherit from (or "extend") class Spin
  # NB: initialize inherited from Spin class

  def display
    stroke_weight 1
    stroke 0
    push_matrix
    translate x, y
    update
    rotate angle
    line 0, 0, 165, 0
    pop_matrix
  end
end

class SpinSpots < Spin
  attr_accessor :dim

  def post_initialize(args)
    @dim = args.fetch(:d, 10)
  end

  def display
    no_stroke
    push_matrix
    translate x, y
    update
    rotate angle
    ellipse(-dim / 2, 0, dim, dim)
    ellipse(dim / 2, 0, dim, dim)
    pop_matrix
  end
end

SubClassSketch.new
