#!/usr/bin/env jruby -v -w
# Description:
# Flight Patterns is that ol' Euruko 2008 demo.
# Reworked version for Propane
# Usage:
# Drag mouse to steer 'invisible' flock attractor, use 'f' key to toggle flee
# Mouse 'click' to toggle 'sphere' or 'circle' display
require 'propane'

class FlightPatterns < Propane::App
  load_library :boids

  attr_reader :flee, :radius

  def settings
    size 1024, 768, P3D
  end

  def setup
    sketch_title 'Flight Patterns'    
    sphere_detail 8
    color_mode RGB, 1.0
    no_stroke
    shininess 1.0
    specular 0.3, 0.1, 0.1
    emissive 0.03, 0.03, 0.1
    @radius = 0.02 * height
    @click = false
    @flee = false
    @flocks = (0..3).map { Boids.flock(n: 20, x: 0, y: 0, w: width, h: height) }
  end

  def mouse_pressed
    @click = !@click
  end

  def key_pressed
    return unless key == 'f'
    @flee = !@flee
  end

  def draw
    background 0.05
    ambient_light 0.01, 0.01, 0.01
    light_specular 0.4, 0.2, 0.2
    point_light 1.0, 1.0, 1.0, mouse_x, mouse_y, 190
    @flocks.each_with_index do |flock, i|
      flock.goal(target: Vec3D.new(mouse_x, mouse_y, 0), flee: @flee)
      flock.update(goal: 185, limit: 13.5)
      flock.each do |boid|
        r = (0.15 * boid.pos.z) + radius
        case i
        when 0 then fill 0.85, 0.65, 0.65
        when 1 then fill 0.65, 0.85, 0.65
        when 2 then fill 0.65, 0.65, 0.85
        end
        push_matrix
        point_array = (boid.pos.to_a).map { |p| p - (r / 2.0) }
        translate(*point_array)
        @click ? sphere(r / 2) : ellipse(0, 0, r, r)
        @click ? hint(ENABLE_DEPTH_TEST) : hint(DISABLE_DEPTH_TEST)
        pop_matrix
      end
    end
  end
end

FlightPatterns.new
