#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true

require 'propane'
require 'arcball'
# DXF DXF Export
# original by Simon Greenwold.
# Translated to propane by Martin Prout
# Rotate by dragging mouse, wheel to zoom.
# Press the 'R' key to export a DXF file.
class DXFExport < Propane::App
  load_library :dxf
  attr_reader :recording

  def setup
    sketch_title 'DXF Export'
    Processing::ArcBall.init(self)
    no_stroke
    sphere_detail(15)
    @recording = false
  end

  def draw
    # Start recording to the file
    begin_raw(DXF, data_path('output.dxf')) if recording
    lights
    background(0)
    mesh_grid(400, 400, 400, 80, 80, 80) do |x, y, z|
      push_matrix
      translate(x - 200, y - 200, z - 200)
      sphere(25)
      pop_matrix
    end
    end_raw if recording
    # Stop recording to the file
    @recording = false
  end

  def key_pressed
    # Press R to save the file
    return unless key == 'R' || key == 'r'

    @recording = true
  end

  def settings
    size(400, 400, P3D)
    smooth(16)
  end
end

DXFExport.new
