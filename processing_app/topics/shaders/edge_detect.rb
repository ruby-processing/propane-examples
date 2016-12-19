#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

class EdgeDetect < Propane::App
  attr_reader :edges, :img , :enabled

  def setup
    sketch_title 'Edge detect'
    @enabled = true
    @img = load_image(data_path('leaves.jpg'))
    @edges = load_shader(data_path('edges.glsl'))
  end

  def draw
    shader(edges) if enabled
    image(img, 0, 0)
  end

  def mouse_pressed
    @enabled = !enabled
    reset_shader if !enabled
  end

  def settings
    size(640, 360, P2D)
  end
end

EdgeDetect.new
