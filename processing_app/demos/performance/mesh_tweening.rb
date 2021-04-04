#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Use mouse_x to control height of mesh
class MeshTweening < Propane::App
  attr_reader :d, :sh

  def settings
    size(640, 360, P3D)
  end

  def setup
    sketch_title 'Mesh Tweening'
    @sh = load_shader(data_path('frag.glsl'), data_path('vert.glsl'))
    @d = 10
    shader(sh)
    no_stroke
  end

  def draw
    background(255)
    sh.set('tween', norm_strict(mouse_x, 0, width))
    translate(width / 2, height / 2, 0)
    rotate_x(frame_count * 0.01)
    rotate_y(frame_count * 0.01)
    fill(150)
    begin_shape(QUADS)
    (-500..500).step(d) do |x|
      (-500..500).step(d) do |y|
        fill(128 * (SmoothNoise.tnoise(x, y) + 1))
        attrib_position('tweened', x, y, 50 * (SmoothNoise.tnoise(x, y) + 1))
        vertex(x, y, 0)
        fill(128 * (SmoothNoise.tnoise(x + d, y) + 1))
        attrib_position('tweened', x + d, y, 50 * (SmoothNoise.tnoise(x + d, y) + 1))
        vertex(x + d, y, 0)
        fill(128 * (SmoothNoise.tnoise(x + d, y + d) + 1))
        attrib_position('tweened', x + d, y + d, 50 * (SmoothNoise.tnoise(x + d, y + d) + 1))
        vertex(x + d, y + d, 0)
        fill(128 * (SmoothNoise.tnoise(x, y + d) + 1))
        attrib_position('tweened', x, y + d, 50 * (SmoothNoise.tnoise(x, y + d) + 1))
        vertex(x, y + d, 0)
      end
    end
    end_shape
  end
end

MeshTweening.new
