#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Ported from http://processing.org/learning/topics/simpleparticlesystem.html
# Particles are generated each cycle, fall with gravity and fade out over
# time. A ParticleSystem (Array) object manages a variable size list of
# particles.
class SimpleParticleSystem < Propane::App
  attr_reader :ps

  def setup
    sketch_title 'Simple Particle System'
    @ps = ParticleSystem.new(Vec2D.new(width / 2, 50))
  end

  def draw
    background(0)
    ps.add_particle
    ps.run
  end

  def settings
    size(640, 360)
  end
end

SimpleParticleSystem.new

# the runnable module
module Runnable
  def run
    self.reject! { |item| item.lifespan <= 0 }
    self.each(&:run)
  end
end

require 'forwardable'
class ParticleSystem
  extend Forwardable
  def_delegators(:@particle_system, :each, :<<, :reject!, :empty?)
  include Enumerable
  include Runnable

  attr_reader :origin

  def initialize(loc)
    @particle_system = []
    @origin = Vec2D.new(loc.x, loc.y)
  end

  def add_particle
    self << Particle.new(origin)
  end

  def dead?
    self.empty?
  end
end

# A simple Particle class

class Particle
  include Propane::Proxy

  attr_reader :loc, :vel, :acc, :lifespan
  def initialize(loc)
    @acc = Vec2D.new(0, 0.05)
    @vel = Vec2D.new(rand(-1.0..1), rand(-2.0..0))
    @loc = loc    # loc.clone is unecessary in ruby
    @lifespan = 255.0
  end

  def run
    update
    display
  end

  # Method to update loc
  def update
    @vel += acc
    @loc += vel
    @lifespan -= 1.0
  end

  # Method to display
  def display
    stroke(255,lifespan)
    fill(255,lifespan)
    ellipse(loc.x, loc.y, 8, 8)
  end
end
