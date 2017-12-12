#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
require 'arcball'

# Export HEC_Johnson to STL
class HEC_JohnsonDemo < Propane::App
  load_library :hemesh
  include_package 'wblut.hemesh'
  java_import 'wblut.geom.WB_AABB'
  java_import 'wblut.processing.WB_Render'

  attr_reader :jmesh, :render, :creator, :current_type

  BOX = WB_AABB.new(-50, -50, -50, 50, 50, 50)

  def settings
    size(200, 200, P3D)
    smooth(8)
  end

  def setup
    sketch_title 'HEC_Johnson'
    Processing::ArcBall.init self
    @current_type = 73
    @jmesh = initialize_johnston(current_type)
    @render = WB_Render.new(self)
  end

  def draw
    background(55)
    setup_lights
    fill(255)
    no_stroke
    render_mesh(jmesh)
  end

  def render_mesh(mesh)
    no_stroke
    render.draw_faces(mesh)
    no_fill
    stroke(0)
    render.draw_edges(mesh)
  end

  def setup_lights
    ambient_light 100, 100, 100
  end

  def mouse_pressed
    @current_type = current_type < 92 ? current_type.succ : 1
    @jmesh = initialize_johnston(current_type)
  end

  def initialize_johnston(index)
    @creator = HEC_Johnson.new
    creator.set_edge(100) # edge length of the polyhedron
    creator.set_type(index) # type of archimedean solid, 1 to 92
    mesh = HE_Mesh.new(creator)
    mesh.fitInAABBConstrained(BOX)
    mesh
  end

  def key_pressed
    return unless key == 's'
    HET_Export.saveToSTL(jmesh, data_path('/'), creator.get_name)
  end
end

HEC_JohnsonDemo.new
