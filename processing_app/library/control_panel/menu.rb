#!/usr/bin/env jruby -w
require 'propane'
class SimpleMenu < Propane::App
  load_library :control_panel

  attr_reader :toggle_loop
  def setup
    sketch_title 'Simple Menu'
    control_panel do |c|
      c.title 'Menu'
      c.menu :choice, %i[one two three]
      c.checkbox(:toggle_loop) { toggle_loop ? loop : no_loop}
    end
  end

  def draw
    puts @choice
    no_loop
  end

  def settings
    size 300, 300
  end
end

SimpleMenu.new
