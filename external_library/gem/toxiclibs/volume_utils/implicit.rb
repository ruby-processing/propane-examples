#!/usr/bin/env jruby
# coding: utf-8
require 'propane'
require 'toxiclibs'
require 'arcball'

#
# This example implements a custom VolumetricSpace using an implicit function
# to calculate each voxel. This is slower than the default array or HashMap
# based implementations, but also has much less memory requirements and so might
# be an interesting and more viable approach for very highres voxel spaces
# (e.g. >32 million voxels). This implementation here also demonstrates how to
# achieve an upper boundary on the iso value (in addition to the one given and
# acting as lower threshold when computing the iso surface)
#
# Usage:
# drag mouse to rotate camera
# mouse wheel zoom in/out
# l: apply laplacian mesh smooth
# Copyright (c) 2010 Karsten Schmidt & propane version Martin Prout 2016
#
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
class Implicit < Propane::App
  RES = 64
  ISO = 0.2
  MAX_ISO = 0.66

  attr_reader :mesh, :vbo, :curr_zoom, :implicit

  def settings
    size(720, 720, P3D)
  end

  def setup
    sketch_title 'Implicit Surface'
    Processing::ArcBall.init(self)
    @vbo = Gfx::MeshToVBO.new(self)
    @curr_zoom = 1
    vol = EvaluatingVolume.new(TVec3D.new(400, 400, 400), RES, RES, RES, MAX_ISO)
    surface = Volume::HashIsoSurface.new(vol)
    @mesh = WETriangleMesh.new
    surface.compute_surface_mesh(mesh, ISO)
    @is_wire_frame = false
    no_stroke
    @implicit = vbo.mesh_to_shape(mesh, true)
    implicit.setFill(color(222, 222, 222))
    implicit.setAmbient(color(50, 50, 50))
    implicit.setShininess(color(10, 10, 10))
    implicit.setSpecular(color(50, 50, 50))
  end

  def draw
    background(0)
    lights
    define_lights
    shape(implicit)
  end

  def key_pressed
    case key
    when 'l', 'L'
      LaplacianSmooth.new.filter(mesh, 1)
      @implicit = vbo.mesh_to_shape(mesh, true)
      # new mesh so need to set finish
      implicit.setFill(color(222, 222, 222))
      implicit.setAmbient(color(50, 50, 50))
      implicit.setShininess(color(10, 10, 10))
      implicit.setSpecular(color(50, 50, 50))
    when 's', 'S'
      save_frame(data_path('implicit.png'))
    when 'p', 'P'
      no_loop
      pm = Gfx::POVMesh.new(self)
      file = java.io.File.new(data_path('implicit.inc'))
      pm.begin_save(file)
      pm.set_texture(Gfx::Textures::WHITE)
      pm.saveAsPOV(mesh, true)
      pm.end_save
      puts 'finished'
    end
  end

  def define_lights
    ambient_light(50, 50, 50)
    point_light(30, 30, 30, 200, -150, 0)
    directional_light(0, 30, 50, 1, 0, 0)
    spot_light(30, 30, 30, 0, 40, 200, 0, -0.5, -0.5, PI / 2, 2)
  end

  # Custom evaluating Volume Class
  class EvaluatingVolume < Volume::VolumetricSpace

    attr_reader :upper_bound
    FREQ = Math::PI * 3.8

    def initialize(scal_vec, resX, resY, resZ, upper_limit)
      super(scal_vec, resX, resY, resZ)
      @upper_bound = upper_limit
    end

    def clear
      # nothing to do here
    end

    def getVoxelAt(i)
      getVoxel(i % resX, (i % sliceRes) / resX, i / sliceRes)
    end

    def getVoxel(x, y, z)  # can't overload so we renamed
      val = 0
      if (x > 0 && x < resX1 && y > 0 && y < resY1 && z > 0 && z < resZ1)
        xx = x * 1.0 / resX - 0.5  # NB: careful about integer division !!!
        yy = y * 1.0 / resY - 0.5
        zz = z * 1.0 / resZ - 0.5
        #val = Math.sin(xx * FREQ) + Math.cos(yy * FREQ) + Math.sin(zz * FREQ)
        val = Math.cos(xx * FREQ) * Math.sin(yy* FREQ) + Math.cos(yy* FREQ) * Math.sin(zz* FREQ) + Math.cos(zz* FREQ)* Math.sin(xx* FREQ)
        if (val > upper_bound)
          val = 0
        end
      end
      return val
    end
  end
end

Implicit.new
