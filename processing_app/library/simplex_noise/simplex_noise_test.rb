# frozen_string_literal: false
require 'propane'
# Test after Karsten Schmidt, SimplexNode after Stefan Gustavson
class SimplexNoiseTest < Propane::App
  load_library :simplex_noise
  attr_reader :noise_dimension, :noise_offset

  NS = 0.05 # (try from 0.005 to 0.5)

  def settings
    size 200, 200, P2D
  end

  def setup
    sketch_title 'Simplex Noise Test'
    @noise_dimension = 0
    @noise_offset = 100
  end

  def draw
    background 0
    (0..width).each do |i|
      (0..height).each do |j|
        noise_val = 0
        case(noise_dimension)
        when 1
          noise_val = SimplexNoise.noise(i * NS + noise_offset, 0)
        when 2
          noise_val = SimplexNoise.noise(i * NS + noise_offset, j * NS + noise_offset)
        when 3
          noise_val = SimplexNoise.noise(i * NS + noise_offset, j * NS + noise_offset, frame_count * 0.01)
        when 4
          noise_val = SimplexNoise.noise(i * NS + noise_offset, j * NS + noise_offset, 0, frame_count * 0.01)
        else
          noise_val = SimplexNoise.noise(i * NS + noise_offset, 0)
        end
        c = (noise_val * 127 + 128).to_i
        # Fix required to return a java signed int
        col = Java::Monkstone::ColorUtil.hex_long(c << 16 | c << 8 | c | 0xff000000)
        set(i, j, col)
      end
    end
    @noise_offset += NS / 2
  end

  def key_pressed
    control_key = %w(1 2 3 4)
    @noise_dimension = key.to_i if control_key.include? key
  end
end

SimplexNoiseTest.new
