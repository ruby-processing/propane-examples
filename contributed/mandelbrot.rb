#!/usr/bin/env jruby
require 'propane'
# Mandelbrot Set example
# by Jordan Scales (http://jordanscales.com)
# Modified to use map1d (instead of map), and somewhat
# optimized (update_pixels instead of set)
# no need to loop
class Mandelbrot < Propane::App

  def setup
    sketch_title 'Mandelbrot'
    load_pixels
    no_loop
  end

  # main drawing method
  def draw
    grid(900, 600) do |x, y|
      c = Complex(
        map1d(x, (0...900), (-3..1.5)), map1d(y, (0...600), (-1.5..1.5))
      )
      # mandel will return 0..20 (20 is strong) map this to 255..0 (NB: reverse)
      pixels[x + y * 900] = color(map1d(mandel(c, 20), (0..20), (255..0)).to_i)
    end
    update_pixels
  end

  # calculates the "accuracy" of a given point in the mandelbrot set
  # how many iterations the number survives without becoming chaotic
  def mandel(z, max = 10)
    score = 0
    c = z
    while score < max
      # z = z^2 + c
      z *= z
      z += c
      break if z.abs > 2
      score += 1
    end
    score
  end

  def settings
    size 900, 600
  end
end

Mandelbrot.new
