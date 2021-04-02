#!/usr/bin/env jruby

require 'propane'
# NB: OpenSimplex has a range -1.0 to 1.0
class NoiseImage < Propane::App
  SCALE = 0.02
  attr_reader :smth
  def setup
    sketch_title 'Noise Image'
    background(0)
    stroke(255)
    no_fill
    @smth = false
  end

  def draw
    background(0)
    scale = 0.02
    load_pixels
    grid(500, 500) do |x, y|
      if smth
        col = SmoothNoise.noise(SCALE * x, SCALE * y) > 0 ? 255 : 0
      else
        col = noise(SCALE * x, SCALE * y) > 0 ? 255 : 0
      end
      pixels[x + width * y] = color(col, 0, 0)
    end
    update_pixels
    # save(data_path('noise_image.png'))
  end

  def mouse_pressed
    @smth = !smth
  end

  def settings
    size 500, 500
  end
end

NoiseImage.new
