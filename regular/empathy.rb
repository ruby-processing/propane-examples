#!/usr/bin/env jruby -v -W2
# Empathy
# original by Kyle McDonald
# http://www.openprocessing.org/visuals/?visualID=1182

# This sketch takes advantage of multiple processors by running calculations
# in a separate thread.
require 'propane'

CELL_COUNT      = 5_000
SLOW_DOWN       = 0.97
ROTATION        = 0.004
LINE_LENGTH     = 37

class Empathy < Propane::App

  attr_reader :cells

  def setup
    size(500, 500)
    stroke(0, 0, 0, 25)
    @cells = create_cells(CELL_COUNT)
    start_cell_updates
  end

  def create_cells(n)
    (0..n).map do |i|
      a = i + rand(PI / 9.0)
      r = ((i / n.to_f) * (width / 2) * (((n - i) / n.to_f) * 3.3)) + rand(6.0)
      Cell.new((r * cos(a) + width / 2).to_i, (r * sin(a) + height / 2).to_i)
    end
  end

  def start_cell_updates
    Thread.new { Kernel.loop { cells.each(&:update) } }
  end

  def draw
    background 255
    cells.each(&:draw_line) if started?
  end

  def started?
    pmouse_x != 0 || pmouse_y != 0
  end

  def mouse_pressed
    cells.each(&:reset)
  end
end

##
# The cell responds to mouse movement
##
class Cell
  include Propane::Proxy, Math
  attr_reader :x, :y, :spin, :angle
  def initialize(x, y)
    @x, @y  = x, y
    reset
  end

  def reset
    @spin, @angle = 0, 0
  end

  def update
    det = ((pmouse_x - x) * (mouse_y - y) - (mouse_x - x) * (pmouse_y - y))
    @spin += ROTATION * det.to_f / dist(x, y, mouse_x, mouse_y)
    @spin *= SLOW_DOWN
    @angle += spin
  end

  def draw_line
    d = LINE_LENGTH * spin + 0.001
    line(x, y, x + d * cos(angle), y + d * sin(angle))
  end
end

Empathy.new(title: 'Empathy')
