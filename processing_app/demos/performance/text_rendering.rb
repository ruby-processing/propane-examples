#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Mad text Rendering
class TextRendering < Propane::App
  def setup
    sketch_title 'Text Rendering'
    fill(0)
  end

  def draw
    background(255)
    (0..10_000).each do
      x = rand(width)
      y = rand(height)
      text("HELLO", x, y)
    end
    puts(format('%d.1', frame_rate)) if (frame_count % 60).zero?
  end

  def settings
    size(800, 600, FX2D)
  end
end

TextRendering.new
