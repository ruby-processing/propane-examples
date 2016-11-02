#!/usr/bin/env jruby -v -W2
require 'propane'
# Get Child.
#
# SVG files can be made of many individual shapes.
# Each of these shapes (called a 'child') has its own name
# that can be used to extract it from the 'parent' file.
# This example loads a map of the United States and creates
# two new PShape objects by extracting the data from two states.
#
class GetChild < Propane::App
  attr_reader :usa, :michigan, :ohio

  def settings
    size(640, 360)
  end

  def setup
    sketch_title 'Get Child'
    @usa = load_shape(data_path('usa-wikipedia.svg'))
    @michigan = usa.get_child('MI')
    @ohio = usa.get_child('OH')
  end

  def draw
    background(255)
    # Draw the full map
    shape(usa, -600, -180)
    # Disable the colors found in the SVG file
    michigan.disable_style
    # Set our own coloring
    fill(0, 51, 102)
    no_stroke
    # Draw a single state
    shape(michigan, -600, -180) # Wolverines!
    # Disable the colors found in the SVG file
    ohio.disable_style
    # Set our own coloring
    fill(153, 0, 0)
    no_stroke
    # Draw a single state
    shape(ohio, -600, -180)  # Buckeyes!
  end
end

GetChild.new
