#!/usr/bin/env jruby
require 'propane'
# RGB Cube.
#
# The three primary colors of the additive color model are red, green, and blue.
# This RGB color cube displays smooth transitions between these colors.
class RgbCube < Propane::App

  attr_reader :box_points

  def setup
    sketch_title 'RGB Cube'
    no_stroke
    color_mode RGB, 2
    @xmag = 0
    @ymag = 0
    @new_xmag = 0
    @new_ymag = 0
    # Math.since each point is used three times
    @box_points = {
      top_front_left: [-1,  1,  1],
      top_front_right: [1,  1,  1],
      top_back_right: [1,  1, -1],
      top_back_left: [-1,  1, -1],
      bottom_front_left: [-1, -1,  1],
      bottom_front_right: [1, -1,  1],
      bottom_back_right: [1, -1, -1],
      bottom_back_left: [-1, -1, -1]
    }
    # a box from defined points
    @box = {
      top: [box_points[:top_front_left], box_points[:top_front_right], box_points[:top_back_right], box_points[:top_back_left]],
      front: [box_points[:top_front_left], box_points[:top_front_right], box_points[:bottom_front_right], box_points[:bottom_front_left]],
      left: [box_points[:top_front_left], box_points[:bottom_front_left], box_points[:bottom_back_left], box_points[:top_back_left]],
      back: [box_points[:top_back_left], box_points[:top_back_right], box_points[:bottom_back_right], box_points[:bottom_back_left]],
      right: [box_points[:top_back_right], box_points[:bottom_back_right], box_points[:bottom_front_right], box_points[:top_front_right]],
      bottom: [box_points[:bottom_front_left], box_points[:bottom_front_right], box_points[:bottom_back_right], box_points[:bottom_back_left]]
    }
  end

  def draw
    background 1
    push_matrix
    translate width / 2, height / 2, -30
    @new_xmag = mouse_x.to_f / width * TAU
    @new_ymag = mouse_y.to_f / height * TAU
    diff = @xmag - @new_xmag
    @xmag -= diff / 4 if diff.abs > 0.01
    diff = @ymag - @new_ymag
    @ymag -= diff / 4 if diff.abs > 0.01
    rotate_x(-@ymag)
    rotate_y(-@xmag)
    scale 90
    begin_shape QUADS
    %i(top front left back right bottom).each do |s|
      @box[s].each do |p|
        fill_from_points p
        vertex_from_points p
      end
    end
    end_shape
    pop_matrix
  end

  def fill_from_points(points)
    fill points[0] + 1, points[1] + 1, points[2] + 1 # "+1" translates -1,1 to 0,2
  end

  def vertex_from_points(points)
    vertex(*points)
  end

  def settings
    size 640, 360, P3D
  end
end

RgbCube.new
