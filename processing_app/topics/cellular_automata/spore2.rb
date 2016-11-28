#!/usr/bin/env jruby
require 'propane'
# Spore 2
# by Mike Davis.
#
# A short program for alife experiments. Click in the window to restart.
# Each cell is represented by a pixel on the display as well as an entry in
# the array 'cells'. Each cell has a run method, which performs actions
# based on the cell's surroundings.  Cells run one at a time (to avoid conflicts
# like wanting to move to the same space) and in random order.
class Spore2 < Propane::App
  load_library :cell
  attr_reader  :cells, :black, :colours, :spore1, :spore2, :spore3, :spore4
  MAX_CELLS = 8_000
  # set lower for smoother animation, higher for faster simulation
  RUNS_PER_LOOP = 10_000

  def setup
    sketch_title 'Spore2'
    frame_rate(24)
    @black = color(0, 0, 0)
    @spore1 = color(128, 172, 255)
    @spore2 = color(64, 128, 255)
    @spore3 = color(255, 128, 172)
    @spore4 = color(255, 64, 128)
    @colours = [spore1, spore2, spore3, spore4]
    reset!
  end

  def reset!
    clear_screen
    seed
  end

  def seed
    load_pixels
    @cells = []
    # Add cells at random places
    MAX_CELLS.times do
      cx = rand(0..width)
      cy = rand(0..height)
      if getpix(cx, cy) == black
        setpix(cx, cy, colours.sample)
        cells << Cell.new(self, cx, cy)
      end
    end
    update_pixels
  end

  def draw
    # Run cells in random order
    RUNS_PER_LOOP.times do
      cells.sample.run
    end
    update_pixels
  end

  def clear_screen
    background(0)
  end

  def setpix(x, y, c)
    x += width while x < 0
    x -= width while x > (width - 1)
    y += height while y < 0
    y -= height while y > (height - 1)
    pixels[y * width + x] = c
  end

  def getpix(x, y)
    x += width while x < 0
    x -= width while x > (width - 1)
    y += height while y < 0
    y -= height while y > (height - 1)
    pixels[y * width + x]
  end

  def mouse_pressed
    reset!
  end

  def settings
    size(640, 360)
  end
end

Spore2.new
