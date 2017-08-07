#!/usr/bin/env jruby
# A simple demonstration of vanilla processing 'reflection' methods using
# propane :library_proxy.
# See library/my_library/my_library.rb code for the guts.
require 'propane'

class KeyEventDemo < Propane::App
  load_libraries :library_proxy, :my_library

  attr_reader :visible

  def settings
    size 300, 200
    @visible = false
  end

  def setup
    sketch_title 'KeyEvent Demo'
    MyLibrary.new self
  end

  def hide(val) # we call this method from my_library
    @visible = !val
  end

  def draw
    if visible
      fill(0, 0, 200)
      ellipse(170, 115, 70, 100)
    else
      background 0
    end
  end
end

KeyEventDemo .new
