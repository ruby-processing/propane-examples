#!/usr/bin/env jruby -w
require 'propane'
# The createImage() function provides a fresh buffer of pixels to play with.
# This example creates an image gradient.
class CreateImage < Propane::App

  def setup
    sketch_title 'Create Image'
    @image = create_image 230, 230, ARGB
    @image.pixels.length.times do |i|
      @image.pixels[i] = color 0, 90, 102, (i % @image.width * 2) # red, green, blue, alpha
    end
  end

  def draw
    background 204
    image @image, 90, 80
    image @image, mouse_x - @image.width, mouse_y - @image.width
  end

  def settings
    size 640, 360
  end
end

CreateImage.new
