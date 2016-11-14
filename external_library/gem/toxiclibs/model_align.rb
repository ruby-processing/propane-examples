#!/usr/bin/env jruby
require 'propane'
require 'toxiclibs'
require 'arcball'
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
class ModelAlign < Propane::App

  # container for mesh positions
  attr_reader :gfx, :positions

  def settings
    size(640, 480, P3D)
  end

  def setup
    sketch_title 'Model Align'
    Processing::ArcBall.init(self)
    @gfx = Gfx::ToxiclibsSupport.new(self)
    # compute mesh positions on circle in XZ plane
    @positions = (Toxi::Circle.new(200).toPolygon2D(8)).map(&:to3DXZ)
  end

  def draw
    background(51)
    lights
    no_stroke
    # create manual focal point in XY plane
    focus = TVec3D.new((mouse_x - width / 2), (mouse_y - height / 2), 0)
    # create mesh prototype to draw at all generated positions
    # the mesh is a simple box placed at the world origin
    m = AABB.new(25).to_mesh
    # draw focus
    gfx.box(AABB.new(focus, 5))
    # align the positive z-axis of mesh to point at focus
    # mesh needs to be located at world origin for it to work correctly
    # only once rotated, move it to actual position
    positions.map { |p| gfx.mesh(m.copy.pointTowards(focus.sub(p), TVec3D::Z_AXIS).translate(p)) }
    # draw connections from mesh centers to focal point
    stroke(0, 255, 255)
    positions.map { |p| gfx.line(p, focus) }
  end
end

ModelAlign.new
