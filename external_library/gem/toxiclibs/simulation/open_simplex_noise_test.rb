#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'
# Test and SimplexNoise Karsten Schmidt
# Better to use Built in OpenSimplex2 in propane
class SimplexNoiseTest < Propane::App
  attr_reader :noise_dimension, :noise_offset

  NS = 0.06 # (try from 0.005 to 0.5)
  KEYS = (1..4).map { |i| i.to_s }
  def settings
    size 300, 300, P2D
  end

  def setup
    sketch_title 'Open Simplex Noise Test'
    @noise_dimension = KEYS[0]
    @noise_offset = 100
    load_pixels
  end

  def draw
    background 0
    grid(width, height) do |i, j|
      noise_val = 0
      case(noise_dimension)
      when KEYS[0]
        noise_val = noise(i * NS + noise_offset, 0)
      when KEYS[1]
        noise_val = noise(i * NS + noise_offset, j * NS + noise_offset)
      when KEYS[2]
        noise_val = noise(i * NS + noise_offset, j * NS + noise_offset, frame_count * 0.01)
      when KEYS[3]
        noise_val = noise(i * NS + noise_offset, j * NS + noise_offset, 0, frame_count * 0.01)
      else
        noise_val = noise(i * NS + noise_offset, 0)
      end
      c = (noise_val * 127 + 128).to_i
      # Fix required to return a java signed int
      col = Java::Monkstone::ColorUtil.hex_long(c << 16 | c << 8 | c | 0xff000000)
      pixels[j * width + i] = col # this is more efficient than set
    end
    update_pixels
    @noise_offset += NS / 2
  end

  def key_pressed
    @noise_dimension = key if KEYS.include? key
  end
end

SimplexNoiseTest.new
