#!/usr/bin/env jruby
require 'propane'
# ParticleSystemPShape
# A particle system optimized for drawing using PShape
# For guts of implementation see 'particle' library
class ParticleSystemPshape < Propane::App
  load_libraries :particle
  # Particle System object and image
  attr_reader :ps
  def setup
    sketch_title 'Particle System Pshape'
    # Load the image
    sprite = load_image(data_path('sprite.png'))
    # A new particle system with 10,000 particles
    @ps = ParticleSystem.new(sprite, 10_000)
    # Writing to the depth buffer is disabled to avoid rendering
    # artifacts due to the fact that the particles are semi-transparent
    # but not z-sorted.
    hint(DISABLE_DEPTH_MASK)
  end

  def draw
    background(0)
    # Update and display system
    ps.update
    ps.display
    # Set the particle system's emitter location to the mouse
    ps.set_emitter(mouse_x, mouse_y)
    # Display frame rate
    fill(255, 0, 255)
    text_size(16)
    text("Frame rate: #{format('%0.2f', frame_rate)}", 10, 20)
  end

  def settings
    size(640, 360, P2D)
  end
end

ParticleSystemPshape.new
