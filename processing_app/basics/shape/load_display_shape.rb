#!/usr/bin/env jruby -v -W2
require 'propane'
# Load and Display a Shape.
# Illustration by George Brower.
#
# The loadShape() command is used to read simple SVG (Scalable Vector Graphics)
# files into a Processing sketch. This library was specifically tested under
# SVG files created from Adobe Illustrator. For now, we can't guarantee that
# it'll work for SVGs created with anything else.
class UglyBots < Propane::App
  attr_reader :bot

  def settings
    size 640, 360
  end

  def setup
    sketch_title 'Ugly Bots'
    @bot = load_shape(data_path('bot1.svg'))
    no_loop
  end

  def draw
    background 102
    shape bot, 110, 90, 100, 100
    shape bot, 280, 40
  end
end

UglyBots.new
