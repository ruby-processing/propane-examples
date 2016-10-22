#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

class Landscape < Propane::App
  #
  # Elevated
  # https://www.shadertoy.com/view/MdX3Rr by inigo quilez
  # Created by inigo quilez - iq/2013
  # License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
  # Processing port by Raphaël de Courville.
  #
  attr_reader :landscape
  java_alias :background_int, :background, [Java::int]  
  TITLE_FORMAT = 'frame: %d - fps: %0.2f'.freeze

  def settings
    size(640, 360, P2D)
  end

  def setup
    sketch_title 'Landscape'
    no_stroke
    # The code of this shader shows how to integrate shaders from shadertoy
    # into Processing/JRubyArt/propane with minimal changes.
    @landscape = load_shader(data_path('landscape.glsl'))
    landscape.set('resolution', width.to_f, height.to_f)
  end

  def draw
    background_int 0
    landscape.set('time', (millis/1000.0).to_f)
    shader(landscape)
    rect(0, 0, width, height)
    sketch_title(format(TITLE_FORMAT, frame_count, frame_rate))
  end
end

Landscape.new
