#!/usr/bin/env jruby -w
require 'propane'
class Checkbox < Propane::App
  load_library :control_panel
  WARN = 'warning!'.freeze
  attr_reader :shouting

  def setup
    sketch_title 'Simple Checkbox'
    control_panel do |c|
      c.look_feel 'Nimbus'
      c.title 'Checkbox'
      c.checkbox :shouting
    end
    text_font(create_font('mono', 48))
    fill(200, 0, 0)
  end

  def warning
    shouting ? WARN.upcase : WARN
  end

  def draw
    background 0
    text(warning, 20, 100)
  end

  def settings
    size 300, 300
  end
end

Checkbox.new
