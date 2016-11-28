# A class to describe a Star shape

class Star
  include Propane::Proxy
  attr_reader :s, :x, :y, :speed, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @x = rand(100..width-100)
    @y = rand(100..height-100)
    @speed = rand(0.5..3)
    # First create the shape
    @s = create_shape
    s.begin_shape
    # You can set fill and stroke
    s.fill(255, 204)
    s.no_stroke
    # Here, we are hardcoding a series of vertices
    s.vertex(0, -50)
    s.vertex(14, -20)
    s.vertex(47, -15)
    s.vertex(23, 7)
    s.vertex(29, 40)
    s.vertex(0, 25)
    s.vertex(-29, 40)
    s.vertex(-23, 7)
    s.vertex(-47, -15)
    s.vertex(-14, -20)
    # The shape is complete
    s.end_shape(CLOSE)
  end

  def move
    # Demonstrating some simple motion
    @x += speed
    @x = -100 if x > (width + 100)
  end

  def display
    # Locating and drawing the shape
    push_matrix
    translate(x, y)
    shape(s)
    pop_matrix
  end

  def run
    move
    display
  end
end
