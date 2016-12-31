#!/usr/bin/env jruby
require 'propane'
require 'toxiclibs'
require_relative 'attractor'
require_relative 'particle'
# Verlet physics example
class AttractRepel < Propane::App

  attr_reader :particles, :attractor, :physics

  def settings
    size 640, 360
  end

  def setup
    sketch_title 'Attract Repel'
    @physics = Physics::VerletPhysics2D.new
    physics.setDrag(0.01)
    @particles = (0..50).map { Particle.new(TVec2D.new(rand(width), rand(height))) }
    @attractor = Attractor.new(TVec2D.new(width / 2, height / 2))
  end

  def draw
    background(255)
    physics.update
    attractor.display
    particles.each(&:display)
    if mouse_pressed?
      attractor.lock
      attractor.set(mouse_x, mouse_y)
    else
      attractor.unlock
    end
  end
end

AttractRepel.new
