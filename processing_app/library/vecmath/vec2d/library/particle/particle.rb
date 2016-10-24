# The Particle System

class ParticleSystem
  include Propane::Proxy

  attr_reader :particles, :particle_shape

  def initialize(width, height, sprite, n)
    @particles = []
    # The PShape is a group
    @particle_shape = create_shape(PConstants::GROUP)

    # Make all the Particles
    n.times do |i|
      particles << Particle.new(width, height, sprite)
      # Each particle's PShape gets added to the System PShape
      particle_shape.add_child(particles[i].s_shape)
    end
  end

  def update
    particles.each do |p|
      p.update
    end
  end

  def set_emitter(x, y)
    particles.each do |p|
      # Each particle gets reborn at the emitter location
      p.rebirth(x, y) if (p.dead?)
    end
  end

  def display
    shape(particle_shape)
  end
end

# An individual Particle

class Particle
  include Propane::Proxy, Math
  GRAVITY = Vec2D.new(0, 0.1)

  attr_reader :center, :velocity, :lifespan, :s_shape, :part_size,
  :boundary_x, :boundary_y, :sprite

  def initialize width, height, sprite
    @sprite = sprite
    @boundary_x = Boundary.new(0, width)
    @boundary_y = Boundary.new(0, height)
    part_size = rand(10..60)
    # The particle is a textured quad
    @s_shape = create_shape
    s_shape.begin_shape(PConstants::QUAD)
    s_shape.no_stroke
    s_shape.texture(sprite)
    s_shape.normal(0, 0, 1)
    s_shape.vertex(-part_size / 2.0, -part_size / 2.0, 0, 0)
    s_shape.vertex(+part_size / 2.0, -part_size / 2.0, sprite.width, 0)
    s_shape.vertex(+part_size / 2.0, +part_size / 2.0, sprite.width, sprite.height)
    s_shape.vertex(-part_size / 2.0, +part_size / 2.0, 0, sprite.height)
    s_shape.end_shape
    # Initialize center vector
    @center = Vec2D.new
    # Set the particle starting location
    rebirth(width / 2.0, height / 2.0)
  end

  def rebirth(x, y)
    theta = rand(-PI..PI)
    speed = rand(0.5..4)
    # A velocity with random angle and magnitude
    @velocity = Vec2D.from_angle(theta)
    @velocity *= speed
    # Set lifespan
    @lifespan = 255
    # Set location using translate
    s_shape.reset_matrix
    s_shape.translate(x, y)
    # Update center vector
    center.x, center.y = x, y
  end

  # Is it off the screen, or its lifespan is over?
  def dead?
    return true if lifespan < 0
    return true if boundary_y.exclude? center.y
    return true if boundary_x.exclude? center.x
    false
  end

  def update
    # Decrease life
    @lifespan = lifespan - 1
    # Apply gravity
    @velocity += GRAVITY
    s_shape.set_tint(color(255, lifespan))
    # Move the particle according to its velocity
    s_shape.translate(velocity.x, velocity.y)
    # and also update the center location
    @center += velocity
  end
end

# unusually in this case we are looking for excluded values
Boundary = Struct.new(:lower, :upper) do
  def exclude? val
    true unless (lower...upper).cover? val
  end
end
