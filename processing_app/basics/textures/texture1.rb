#!/usr/bin/env jruby
require 'propane'
require 'arcball'
# Texture 1.
#
# Load an image and draw it onto a quad. The texture() function sets
# the texture image. The vertex() function maps the image to the geometry.
class Texture1 < Propane::App
  def setup
    sketch_title 'Texture 1'
    Processing::ArcBall.init(self)
    @img = load_image(data_path('berlin-1.jpg'))
    no_stroke
  end

  def draw
    background 0
    begin_shape
    texture @img
    vertex(-100, -100, 0, 0, 0)
    vertex(100, -100, 0, @img.width, 0)
    vertex(100, 100, 0, @img.width, @img.height)
    vertex(-100, 100, 0, 0, @img.height)
    end_shape
  end

  def settings
    size 640, 360, P3D
  end
end

Texture1.new
