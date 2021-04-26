#!/usr/bin/env jruby
require 'propane'

# Based on a sketch by Javi F Gorostiza
# https://openprocessing.org/sketch/432548
class PsychedelicNoise < Propane::App
  load_library :generator
  attr_reader :img, :colors, :remap1, :remap2

  def setup
    sketch_title 'Psychedelic Noise Pattern'
    color_mode(RGB, 1.0)
    @theta = 0
    @phi = 0
    # the dimensions of the image are twice the dimentions of
    # the canvas to add antialiasing when the image is reduced
    @img = create_image(2 * width, 2 * height, RGB)
    @colors = (0..255).map { color(rand, rand, rand) }
  end


  def draw
    # fill the array with rand colors
    # create pattern
    img.load_pixels
    iwidth = img.width
    iheight = img.height

    grid(iwidth, iheight) do |x, y|
      # map x and y to angles between 0 and TWO_PI
      theta = map1d(x, 0..iwidth, 0..TWO_PI)
      phi = map1d(y, 0..iheight, 0..TWO_PI)
      generator = Generator.new(phi, theta)
      # apply noise twice and use the equivalent color on the pallete
      img.pixels[x + y * iwidth] = colors[generator.noisef(frame_count / 5)]
    end
    img.update_pixels
    # display pattern
    image(img, 0, 0, width, height) # the image is reduce to the size of the canvas to make it smooth
  end

  def key_pressed
    save(data_path('image.png'))
  end

  def settings
    size(500, 500)
  end
end

PsychedelicNoise.new
