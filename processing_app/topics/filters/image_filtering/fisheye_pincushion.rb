#!/usr/bin/env jruby
require 'propane'
# Bilinear smoothing
# Original shader by mrharicot
# https://www.shadertoy.com/view/4dfGDH
# Ported to Processing by Raphaël de Courville <twitter: @sableRaph>
# Ported to propane by Martin Prout
# Hold mouse click to show unfiltered image
class FisheyePincushion < Propane::App
  load_library :control_panel
  attr_reader :my_filter, :my_image, :amount

  def settings
    size(512, 512, P2D)
  end

  def setup
    sketch_title 'FishEye / Pincushion'
    setup_control
    @my_image  = load_image(data_path('texture.jpg'))
  end

  def draw
    background(0)
    @my_filter = load_shader(data_path('fish_eye.glsl'))
    my_filter.set('sketchSize', width.to_f, height.to_f)
    # Draw the image on the scene
    image(my_image, 0, 0)
    # Set the fisheye amount (the range is between -0.5 and 0.5)
    # Negative for pincushion and positive for fisheye
    my_filter.set('amount', amount / 100)
    filter(my_filter)
  end

  def setup_control
    control_panel do |c|
      c.look_feel 'Nimbus'
      c.title = 'adjust pin..fish'
      c.slider :amount, -50.0..50.0, 0      
    end
  end
end

FisheyePincushion.new
