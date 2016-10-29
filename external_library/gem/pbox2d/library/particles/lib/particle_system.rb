require 'forwardable'

module Runnable
  def run
    reject!(&:done)
    each(&:display)
  end
end

# Not be confused with the jbox2d ParticleSystem
class ParticleSystem
  include Enumerable, Runnable
  extend Forwardable
  def_delegators(:@particles, :each, :reject!, :<<, :empty?)
  def_delegator(:@particles, :empty?, :dead?)

  attr_reader :x, :y

  def initialize(bd, num, x, y)
    @particles = []          # Initialize the Array
    @x, @y = x, y            # Store the origin point
    num.times do
      self << Particle.new(bd, x, y)
    end
  end

  def add_particles(bd, n)
    n.times do
      self << Particle.new(bd, x, y)
    end
  end
end


