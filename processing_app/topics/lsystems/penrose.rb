#!/usr/bin/env jruby
require 'propane'
#######################################################
# penrose tiling in propane using LSystems
# by Martin Prout
######################################################
class Penrose < Propane::App
  load_library :grammar
  attr_reader :penrose

  def settings
    size 800, 800
    smooth
  end

  def setup
    sketch_title 'Penrose Colored'
    stroke_weight 2
    @penrose = PenroseColored.new(width / 2, height / 2)
    penrose.create_grammar 5
    no_loop
  end

  def draw
    background 0
    penrose.render
  end
end

Penrose.new
