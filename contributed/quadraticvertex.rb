#!/usr/bin/env jruby
require 'propane'
# sketch by Jan Vantomme
# Part of a series of articles on Processing 2.
# Blog post here:
# http://vormplus.be/blog/article/drawing-shapes-with-quadratic-vertices
# translated for JRubyArt by Martin Prout
# Note how to specify fill and background using hexadecimal string for color,
# this is different from vanilla processing
class Quadraticvertex < Propane::App

  load_library :control_panel

  attr_reader :debug, :save_one, :step_angle, :cr, :detail, :panel, :hide

  def setup
    sketch_title 'Quadratic Vertex'
    @hide = false
    control_panel do |c|
      c.title = 'Controller'
      c.menu(:detail, %w(4 5 6 7 8 9 10), '7')
      c.checkbox :debug
      c.button :save_image
      @panel = c
    end
    @save_one = false
  end

  def draw
    unless hide
      panel.set_visible true
      @hide = true
    end
    background color('#BDF018')
    translate width / 2, height / 2
    @step_angle = TAU / (detail.to_i - 1)
    fill color('#ffffff')
    no_stroke
    @cr = map1d(mouse_x, (0..width) , (20..200))
    begin_shape
    detail.to_i.times do |i|
      if (i == 0)
        vertex cos_x(i), sin_y(i)
      else
        quadratic_vertex cos_cx(i), sin_cy(i), cos_x(i), sin_y(i)
      end
    end
    end_shape(CLOSE)
    if debug
      # draw lines between points
      stroke_weight(1)
      no_fill
      stroke(0)
      begin_shape
      detail.to_i.times do |i|
        vertex cos_cx(i), sin_cy(i) unless i == 0
        vertex cos_x(i), sin_y(i)
      end
      end_shape CLOSE
      # draw points
      stroke_weight 8
      detail.to_i.times do |i|
        stroke 0
        point cos_x(i), sin_y(i)
        stroke 255, 0, 0
        point cos_cx(i), sin_cy(i)
      end
    end
    return unless save_one
    save_frame('images/quadraticvertex-#####.png')
    @save_one = false
  end

  def mouse_pressed
    @hide = false
  end

  def cos_x(n)
    cos(step_angle * n) * 100
  end

  def sin_y(n)
    sin(step_angle * n) * 100
  end

  def cos_cx(n)
    cos(step_angle * n - (step_angle / 2)) * cr
  end

  def sin_cy(n)
    sin(step_angle * n - (step_angle / 2)) * cr
  end

  def save_image
    @save_one = true
  end

  def settings
    size 450, 320
    smooth 8
  end
end

Quadraticvertex.new
