#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
# Adapted to use Propane Vec2D and Vec3D classes by Martin Prout

# Use Face Struct triangle 'mesh'.
Face = Struct.new(:a, :b, :c) # triangle mesh face
require 'propane'

# Monkey patch the Vec3D class to support rotations
Vec3D.class_eval do # re-open the Vec3D class to add the rotate methods
  def rotate_y!(theta)
    co = Math.cos(theta)
    si = Math.sin(theta)
    xx = co * x - si * z
    self.z = si * x + co * z
    self.x = xx
    self
  end

  def rotate_x!(theta)
    co = Math.cos(theta)
    si = Math.sin(theta)
    zz = co * z - si * y
    self.y = si * z + co * y
    self.z = zz
    self
  end
end

# After a toxiclibs "MeshDoodle" sketch by Karsten Schmidt
class Doodle < Propane::App
  attr_reader :prev, :p, :q, :rotation, :faces, :pos, :weight

  def setup
    size(600, 600, P3D)
    @weight = 0
    @prev = Vec3D.new
    @p = Vec3D.new
    @q = Vec3D.new
    @rotation = Vec2D.new
    @faces = []
  end

  def draw
    background(0)
    lights
    translate(width / 2, height / 2, 0)
    rotate_x(rotation.x)
    rotate_y(rotation.y)
    no_stroke
    begin_shape(TRIANGLES)
    # iterate over all faces/triangles of the 'mesh'
    faces.each do |f|
      # create vertices for each corner point
      f.a.to_vertex(renderer)
      f.b.to_vertex(renderer)
      f.c.to_vertex(renderer)
    end
    end_shape
    # update rotation
    @rotation += Vec2D.new(0.014, 0.0237)
  end

  def mouse_moved
    # get 3D rotated mouse position
    @pos = Vec3D.new(mouse_x - width / 2, mouse_y - height / 2, 0)
    pos.rotate_x!(rotation.x)
    pos.rotate_y!(rotation.y)
    # use distance to previous point as target stroke weight
    @weight += (sqrt(pos.dist(prev)) * 2 - weight) * 0.1
    # define offset points for the triangle strip
    a = pos + Vec3D.new(0, 0, weight)
    b = pos + Vec3D.new(0, 0, -weight)
    # add 2 faces to the mesh
    faces << Face.new(p, b, q)
    faces << Face.new(p, a, b)
    # store current points for next iteration
    @prev = pos
    @p = a
    @q = b
  end

  # An example of AppRenderer usage for Vec3D => vertex conversion
  def renderer
    @renderer ||= Propane::Render::AppRender.new(self)
  end
end

Doodle.new title: 'Ribbon Doodle'
