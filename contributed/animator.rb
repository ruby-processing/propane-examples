#!/usr/bin/env jruby
require 'propane'

class Animator < Propane::App
  FRAME_COUNT = 12

  def settings
    size 350, 350
    # pixel_density(2) # for HiDpi screens
    # smooth see https://processing.org/reference/smooth_.html
  end

  def setup
    sketch_title 'Animator'
    @frames         = []
    @last_time      = 0
    @current_frame  = 0
    @draw           = false
    @back_color     = 204
    stroke_weight 4
    background @back_color
    FRAME_COUNT.times { @frames << get }
  end

  def draw
    time = millis
    if time > @last_time + 100
      next_frame
      @last_time = time
    end
    line(pmouse_x, pmouse_y, mouse_x, mouse_y) if @draw
  end

  def mouse_pressed
    @draw = true
  end

  def mouse_released
    @draw = false
  end

  def key_pressed
    background @back_color
    @frames.size.times { |i| @frames[i] = get }
  end

  def next_frame
    @frames[@current_frame] = get
    @current_frame += 1
    @current_frame = 0 if @current_frame >= @frames.size
    image(@frames[@current_frame], 0, 0)
  end
end

Animator.new
