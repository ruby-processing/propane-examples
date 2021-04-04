# frozen_string_literal: true
# An object that wraps the PShape
class Wiggler
  include Propane::Proxy
  attr_reader :original, :x, :y, :s, :yoff, :xoff

  def initialize width, height
    @x = width/2
    @y = height/2
    @yoff = 0
    # The 'original' locations of the vertices make up a circle
    @original = []
    (0...TAU).step(0.2) do |a|
      v = Java::ProcessingCore::PVector::from_angle(a)
      v.mult(100)
      original << v
    end

    # Now make the PShape with those vertices
    @s = create_shape
    s.begin_shape
    s.fill(127)
    s.stroke(0)
    s.stroke_weight(2)
    original.each do |v|
      s.vertex(v.x, v.y)
    end
    s.end_shape(CLOSE)
  end

  def wiggle
    @xoff = 0
    # Apply an offset to each vertex
    (0...s.get_vertex_count).each do |i|
      # Calculate a new vertex location based on noise around 'original' location
      pos = original[i]
      a = PI * SmoothNoise.noise(xoff, yoff)
      r = Java::ProcessingCore::PVector::from_angle(a)
      r.mult(4)
      r.add(pos)
      # Set the location of each vertex to the new one
      s.set_vertex(i, r.x, r.y)
      # increment noise x value
      @xoff += 0.5
    end
    # Increment noise y value
    @yoff += 0.02
  end

  def display
    push_matrix
    translate(x, y)
    shape(s)
    pop_matrix
  end
end
