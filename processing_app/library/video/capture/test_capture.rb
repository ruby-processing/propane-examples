#!/usr/bin/env jruby
require 'propane'

# Test Class for Video Library
class TestCapture < Propane::App
  load_library :video
  java_import 'processing.video.Capture'
  attr_reader :cam, :cameras

  def setup
    sketch_title 'Test Capture'
    @cameras = Capture.list
    fail 'There are no matching cameras.' if cameras.length.zero?
    start_capture(cameras[0])
    font = create_font('DejaVu Sans', 28)
    text_font font, 28    
  end

  def start_capture(cam_string)
    # The camera can be initialized directly using an
    # element from the array returned by list:
    @cam = Capture.new(self, width, height, cam_string)
    p format('Using camera %s', cam_string)
    cam.start
  end

  def draw
    return unless cam.available

    cam.read
    set(0, 0, cam)
    fill 255
    rect 0, height - 80, width, 50
    fill 0
    text cameras[0], 30, height - 50
  end

  def settings
    size 960, 720, P2D
  end
end

TestCapture.new
