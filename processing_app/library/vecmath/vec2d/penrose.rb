#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true

require 'propane'
# Penrose Tile Generator
# Using a variant of the "ArrayList" recursion technique: http://natureofcode.com/book/chapter-8-fractals/chapter08_section4
# Penrose Algorithm from: http://preshing.com/20110831/penrose-tiling-explained
# Daniel Shiffman May 2013
# Translated (and refactored) to JRubyArt July 2015 by Martin Prout
class Penrose < Propane::App
  load_libraries :control_panel, :tile
  attr_reader :tris, :s, :acute

  def setup
    sketch_title 'Penrose'
    control_panel do |c|
      c.title 'Tiler Control'
      c.look_feel 'Nimbus'
      c.checkbox  :seed
      c.checkbox  :acute
      c.button    :generate
      c.button    :reset!
    end
    init false # defaults to regular penrose
  end

  def draw
    background(255)
    translate(width / 2, height / 2)
    tris.each(&:display)
  end

  def generate
    next_level = []
    tris.each do |t|
      more = t.subdivide
      more.each do |m|
        next_level << m
      end
    end
    @tris = next_level
  end

  def reset!
    Tiler.acute(acute)  # set the Tiler first
    init @seed
    java.lang.System.gc # but does it do any good?
  end

  def init(alt_seed)
    @tris = []
    10.times do |i|     # create 36 degree segments
      a = Vec2D.new
      b = Vec2D.from_angle((2 * i - 1) * PI / 10)
      c = Vec2D.from_angle((2 * i + 1) * PI / 10)
      b *= 370
      c *= 370
      if alt_seed
        tile = i.even? ? Tiler.tile(b, a, c) : Tiler.tile(c, a, b)
        tris << tile
      else
        tile = i.even? ? Tiler.tile(a, b, c) : Tiler.tile(a, c, b)
        tris << tile
      end
    end
  end

  def settings
    size 1024, 576
  end
end

Penrose.new
