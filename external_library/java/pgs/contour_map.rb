#!/usr/bin/env jruby --dev
require 'propane'
require_relative './vector_list'
class ContourMap < Propane::App
  load_library :pgs
  java_import 'micycle.pgs.PGS_Contour'

  attr_reader :heights, :max, :min
  MAX = -1
  MIN = 9999

  def setup
    sketch_title 'Contour Map'
    @max = MAX
    @min = MIN
  end

  def draw
    background(0, 0, 40)
    populate_height_map
    isolines = PGS_Contour.isolines(heights.array_list, 0.08, min, max)
    isolines.to_hash.each do |isoline, value|
      isoline.set_stroke(
        color(
          map1d(value, min..max, 50..255),
          map1d(isoline.get_vertex(0).x, 0..width, 50..255),
          map1d(isoline.get_vertex(0).y, 0..height, 50..255)
        )
      )
      shape(isoline)
    end
  end

  def populate_height_map
    @heights = VectorList.new

    res = 16
    anim_speed = 0.005

    grid(width + res, height + res, res, res) do |x, y|
      z = norm(noise(x*0.01 + frame_count*anim_speed, y*0.01 + frame_count*anim_speed), -1.0, 1.0)
      h = Vec3D.new(x, y, 0)
      z += h.dist(Vec3D.new(mouse_x, mouse_y, 0))*0.005
      h.z = z
      heights << h
      @max = [max, z].max
      @min = [min, z].min
    end
  end

  def settings
    size(800, 800)
  end
end

ContourMap.new