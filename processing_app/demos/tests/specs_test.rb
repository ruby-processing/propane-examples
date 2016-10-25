#!/usr/bin/env jruby
# coding: utf-8
require 'propane'

class SpecTests < Propane::App
  include_package 'processing.opengl'

  def setup
    sketch_title 'Graphics Spec Test'
    puts(PGraphicsOpenGL.OPENGL_VENDOR)
    puts(PGraphicsOpenGL.OPENGL_RENDERER)
    puts(PGraphicsOpenGL.OPENGL_VERSION)
    puts(PGraphicsOpenGL.GLSL_VERSION)
    puts(PGraphicsOpenGL.OPENGL_EXTENSIONS)
  end

  def settings
    size(200, 100, P3D)
  end
end

SpecTests.new
