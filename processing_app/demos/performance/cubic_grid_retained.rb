#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'

########################
# NB: Bit slow to get going
# but, performs Ok after
########################
class CubicGridRetained < Propane::App
  BOX_SIZE = 20
  MARGIN = BOX_SIZE * 2
  DEPTH = 200 # reduced for jruby-9.1.5.0 memory hog
  FINT = 3

  attr_reader :box_fill, :grid, :fcount, :lastm, :frate

  def setup
    sketch_title 'Cubic Grid Retained'
    #frame_rate(60)
    @fcount = 0
    @lastm = 0
    no_stroke
    @grid = create_shape(GROUP)
    # Build grid using multiple translations
    (-(DEPTH/2 + MARGIN)...(DEPTH/2 - MARGIN)).step(BOX_SIZE) do |i|
      (-(height + MARGIN)...(height - MARGIN)).step(BOX_SIZE) do |j|
        (-(width + MARGIN)...(width - MARGIN)).step(BOX_SIZE) do |k|
          # Base fill color on counter values, abs function
          # ensures values stay within legal range
          @box_fill = color(i.abs.to_i, j.abs.to_i, k.abs.to_i, 50)
          cube = create_shape(BOX, BOX_SIZE.to_f, BOX_SIZE.to_f, BOX_SIZE.to_f)
          cube.set_fill(box_fill)
          cube.translate(k, j, i)
          grid.add_child(cube)
        end
      end
    end
  end

  def draw
    background(255)
    hint(DISABLE_DEPTH_TEST)
    # Center and spin grid
    push_matrix
    translate(width / 2, height / 2, -DEPTH)
    rotate_y(frame_count * 0.01)
    rotate_x(frame_count * 0.01)
    shape(grid)
    pop_matrix
    hint(ENABLE_DEPTH_TEST)
    @fcount += 1
    m = millis
    if (m - lastm > 1000 * FINT)
      @frate = fcount / FINT
      @fcount = 0
      @lastm = m
      # puts(format('fps: %s', frate))
    end
    fill(0)
    text(format('fps: %s', frate), 10, 20)
  end

  def settings
    size(640, 360, P3D)
    no_smooth
  end
end

CubicGridRetained.new
