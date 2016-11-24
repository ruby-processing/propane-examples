#!/usr/bin/env jruby
require 'propane'
require 'arcball'

class Texture3 < Propane::App
# Texture 3.
#
# Load an image and draw it onto a cylinder and a quad.

attr_reader :tube_res, :tube_x, :tube_y, :img

def setup
sketch_title 'Texture 3'
Processing::ArcBall.init(self)
@tube_res = 32
@tube_x = []
@tube_y = []
@img = load_image(data_path('berlin-1.jpg'))
angle = 270 / tube_res
(0...tube_res).each do |i|
tube_x.push DegLut.cos(i * angle)
tube_y.push DegLut.sin(i * angle)
end
no_stroke
end

def draw
background 0
begin_shape QUAD_STRIP
texture img
(0...tube_res).each do |i|
x = tube_x[i] * 100
z = tube_y[i] * 100
u = img.width / tube_res * i
vertex x, -100, z, u, 0
vertex x,  100, z, u, img.height
end
end_shape
begin_shape QUADS
texture img
vertex   0, -100, 0,   0, 0
vertex 100, -100, 0, 100, 0
vertex 100,  100, 0, 100, 100
vertex   0,  100, 0,   0, 100
end_shape
end

def settings
size 640, 360, P3D
end
end

Texture3.new
