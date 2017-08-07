#!/usr/bin/env jruby
require 'propane'

class MouseEventDemo < Propane::App
  load_libraries :library_proxy, :mouse_thing
  attr_reader :thing

  def settings
    size(800, 600)
  end

  def setup
    sketch_title 'Mouse Event Demo'
    @thing = MouseThing.new(self)
  end

  def draw
    background(255)
  end
end

MouseEventDemo.new
