class Ring
  include Propane::Proxy
  attr_reader :x, :y, :diameter
  attr_accessor :on

  def start(x, y)
    @x = x
    @y = y
    @on = true
    @diameter = 1
  end

  def grow
    return unless on
    @diameter += 0.5
    @diameter = 0 if diameter > width * 1.5
  end

  def display
    return unless on
    no_fill
    stroke_weight 4
    stroke 155, 153
    ellipse x, y, diameter, diameter
  end
end
