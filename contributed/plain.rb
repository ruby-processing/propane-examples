#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'

# Demonstrates use of the 4 parameter grid convenience method, where parameters
# 3 and 4 represent the size of the grid cell
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
    grid(width / dim, height / dim, dim, dim) do |i, j|
      rect i, j, dim, dim, rnd, rnd, rnd, rnd
    end
    no_loop
  end

  def settings
    full_screen
  end
end

Plain.new
