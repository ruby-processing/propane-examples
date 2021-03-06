require 'propane'
# OpenSimplex has a range -1.0 to 1.0
class NoiseImage < Propane::App
  SCALE = 0.02

  def setup
    sketch_title 'Noise Image'
    background(0)
    stroke(255)
    no_fill
  end

  def draw
    background(0)
    scale = 0.02
    load_pixels
    grid(500, 500) do |x, y|
      col = noise(SCALE * x, SCALE * y) > 0 ? 255 : 0
      pixels[x + width * y] = color(col, 0, 0)
    end
    update_pixels
    save(data_path('noise_image.png'))
  end

  def settings
    size 500, 500
  end
end

NoiseImage.new
