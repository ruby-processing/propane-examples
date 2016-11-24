class Egg
  include Propane::Proxy
  attr_reader :angle, :x, :y, :tilt, :scalar

  def initialize(x, y, t, s)
    @x, @y, @tilt, @scalar = x, y, t, s / 100.0
    @angle = 0
  end

  def wobble
    @tilt = cos(angle) / 8
    @angle += 0.1
  end

  def display
    no_stroke
    fill 255
    push_matrix
    translate(x, y)
    rotate(tilt)
    scale(scalar)
    begin_shape
    vertex(0, -100)
    bezier_vertex(25, -100, 40, -65, 40, -40)
    bezier_vertex(40, -15, 25, 0, 0, 0)
    bezier_vertex(-25, 0, -40, -15, -40, -40)
    bezier_vertex(-40, -65, -25, -100, 0, -100)
    end_shape
    pop_matrix
  end
end
