#!/usr/bin/env jruby -w
require 'propane'
# Loads a "mask" for an image to specify the transparency
# in different parts of the image. The two images are blended
# together using the mask() method of PImage.
class AlphaMask < Propane::App
  def setup
    sketch_title 'Alpha Mask'
    @image = load_image(data_path('test.jpg'))
    @image_mask = load_image(data_path('mask.jpg'))
    @image.mask @image_mask
  end

  def draw
    background((mouse_x + mouse_y) / 1.5)
    image @image, width / 2, height / 2
    image @image, mouse_x - @image.width, mouse_y - @image.height
  end

  def settings
    size 640, 360
  end
end

AlphaMask.new
