# frozen_string_literal: true
require 'propane'

class NewtonFractal < Propane::App
  IMGX = 512
  IMGY = 512
  MAXIT = 20 # max iterations allowed
  EPS = 1e-3 # max error allowed
  COMPLEX = Complex(1e-6, 1e-6) # step increment

  attr_reader :xa, :xb, :ya, :yb, :z

  def settings
    size(IMGX, IMGY)
  end

  def setup
    sketch_title 'Newton Fractal'
    color_mode(HSB)
    # Drawing area
    @xa = -1.0
    @xb = 1.0
    @ya = -1.0
    @yb = 1.0
    no_loop
  end

  def draw
    load_pixels
    grid(IMGY, IMGX) do |y, x|
      zy = y * (yb - ya) / (IMGY - 1) + ya
      zx = x * (xb - xa) / (IMGX - 1) + xa
      @z = Complex(zx, zy)
      (0...MAXIT).each do |i|
        # Newton iteration
        z0 =  z - func(z) / ((func(z + COMPLEX) - func(z)) / COMPLEX)
        break if (z0 - z).abs < EPS

        @z = z0
        # pixels[x + y * width] = color(i % 5 * 64, i % 17 * 16, i % 9 * 32)
        pixels[x + y * width] = color(i % 5 * 64, i % 9 * 32, i % 17 * 16)
      end
    end
    update_pixels
  end

  def func(z)
    z**3 - 1.0
    # z**4 - 1.0
  end
end

NewtonFractal.new
