#!/usr/bin/env jruby --dev
require 'propane'
# From an original shader by RavenWorks
# hold down mouse to see unfiltered output
class Steinberg < Propane::App
  load_library :video
  java_import 'processing.video.Capture'
  attr_reader :cam, :my_shader

  def settings
    size(640, 480, P2D)
  end

  def setup
    sketch_title 'Steinberg'
    @my_shader = load_shader(data_path('steinberg.glsl'))
    my_shader.set('sketchSize', width.to_f, height.to_f)
    start_capture(width, height)
  end

  def start_capture(w, h)
    @cam = Capture.new(self, width, height, 'UVC Camera (046d:0825)')
    cam.start
  end

  def draw
    return unless cam.available

    background 0
    cam.read
    set(0, 0, cam)
    # image(cam, 0, 0, width, height)
    return if mouse_pressed?

    filter(my_shader)
  end
end

Steinberg.new
