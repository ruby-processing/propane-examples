require 'propane'
# WigglePShape. Demonstrates initialization and use of Propane::ShapeRender,
# that allows us to send Vec2D to PShape vertex see wiggler.rb
#
# How to move the individual vertices of a PShape
#
class Wiggling < Propane::App
  load_library :wiggler
  attr_reader :wiggler

  def setup
    sketch_title 'Wiggle PShape'
    @wiggler = Wiggler.new width, height
  end

  def draw
    background(255)
    wiggler.display
    wiggler.wiggle
  end
  def settings
    size(640, 360, P2D)
  end
end

Wiggling.new
