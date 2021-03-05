require 'propane'

class DemoNoise < Propane::App
  attr_reader :z

  def setup
    sketch_title 'Demo noise_mode'
    stroke(255, 64)
    @z = 0
  end

  def draw
    noise_scale = 0.01
    background(0)
    grid(width, height, 10, 10) do |x, y|
      arrow(x, y, noise(x * noise_scale, y * noise_scale, z * noise_scale) * TWO_PI * 2)
    end
    @z += 1
  end

  def mouse_pressed
    mode = Propane::SIMPLEX
    noise_mode mode
    sketch_title "#{mode}"
  end

  def mouse_released
    mode = Propane::VALUE
    noise_mode(mode)
    sketch_title "#{mode}"
  end


  def arrow(x, y, ang)
    pushMatrix()
    translate(x, y)
    rotate(ang)
    line(0, 0, 20, 0)
    translate(20, 0)
    rotate(PI + 0.4)
    line(0, 0, 5, 0)
    rotate(-0.8)
    line(0, 0, 5, 0)
    popMatrix()
  end

  def settings
    size(600, 400, P2D)
  end
end

DemoNoise.new
