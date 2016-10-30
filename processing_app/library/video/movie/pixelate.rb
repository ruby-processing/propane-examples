#!/usr/bin/env jruby -w
require 'propane'
#
# Pixelate
# by Hernando Barragan.
#
# Load a QuickTime file and display the video signal
# using rectangles as pixels by reading the values stored
# in the current video frame pixels array.
class Pixelate < Propane::App
  load_library :video
  include_package 'processing.video'

  BLOCK_SIZE = 10

  attr_reader :mov, :movie_color, :num_pixels_wide, :num_pixels_high

  def setup
    sketch_title 'Pixelate'
    no_stroke
    @mov = Movie.new(self, data_path('transit.mov'))
    @num_pixels_wide = width / BLOCK_SIZE
    @num_pixels_high = height / BLOCK_SIZE
    @movie_color = []
    puts num_pixels_wide
    mov.loop
  end

  # Display values from movie
  def draw
    if mov.available?
      movie_color.clear
      mov.read
      mov.load_pixels
      num_pixels_high.times do |j|
        num_pixels_wide.times do |i|
          movie_color << mov.get(i * BLOCK_SIZE, j * BLOCK_SIZE)
        end
      end
    end
    num_pixels_high.times do |j|
      num_pixels_wide.times do |i|
        fill(*movie_color[j * num_pixels_wide + i])
        rect(i * BLOCK_SIZE, j * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
      end
    end
  end

  def settings
    size 640, 360, P2D
  end
end

Pixelate.new
