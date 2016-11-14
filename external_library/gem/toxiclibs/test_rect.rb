#!/usr/bin/env jruby
require 'propane'
require 'toxiclibs'
# A propane sketch
#
# Copyright (c) 2010 Karsten Schmidt & propane version Martin Prout 2016
# This library is free software you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation either
# version 2.1 of the License, or (at your option) any later version.
#
# http://creativecommons.org/licenses/LGPL/2.1/
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
class TestRect < Propane::App
  # click mouse on sketch several times and you will
  # see the Toxi::Rect grow to include new data points
  attr_reader :points, :bounds, :gfx

  def settings
    size(400,400)
  end

  def setup
    sketch_title 'Test Rect'
    @points = []
    @bounds = Toxi::Rect.new(200, 200, 0, 0)
    @gfx = Gfx::ToxiclibsSupport.new(self)
  end

  def draw
    background(255)
    no_fill
    stroke(0)
    gfx.rect(bounds)
    fill(255, 0, 0)
    no_stroke
    points.each { |p| gfx.circle(p, 5) }
  end

  def mouse_pressed
    p = TVec2D.new(mouse_x, mouse_y)
    points << p
    bounds.grow_to_contain_point(p)
  end
end

TestRect.new
