#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'

class Plain < Propane::App

  attr_reader :dim, :rnd
  def setup
    sketch_title 'Plain'
    @dim = height / 6
    @rnd = dim / 10
  end

  def draw
    background 0
    fill 120, 160, 220
    stroke 0
    rect_mode(CENTER)
    (dim..width - dim).step(dim) do |x|
      (dim..height - dim).step(dim) do |y|
        rect x, y, dim, dim, rnd, rnd, rnd, rnd
      end
    end
  end

  def settings
    full_screen
  end
end

Plain.new
