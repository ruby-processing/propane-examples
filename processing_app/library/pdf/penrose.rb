#!/usr/bin/env jruby
# frozen_string_literal: true

require 'propane'
#######################################################
# penrose tiling in propane using LSystems
# by Martin Prout
######################################################
class Penrose < Propane::App
  load_library :grammar, :penrose, :pdf
  attr_reader :penrose

  def settings
    size 800, 800
  end

  def setup
    sketch_title 'Penrose Colored'
    begin_record(PDF, data_path('penrose.pdf'))
    stroke_weight 2
    @penrose = PenroseColored.new(width / 2, height / 2)
    penrose.create_grammar 5
    no_loop
  end

  def draw
    background 0
    penrose.render
    fill 200, 200, 0
    text("axiom = '[X]2+[X]2+[X]2+[X]2+[X]'", 10, 15)
    text("'F' => ''", 10, 30)
    text("'W' => 'YBF2+ZRF4-XBF[-YBF4-WRF]2+'", 10, 45)
    text("'X' => '+YBF2-ZRF[3-WRF2-XBF]+'", 10, 60)
    text("'Y' => '-WRF2+XBF[3+YBF2+ZRF]-'", 10, 75)
    text("'Z' =>'2-YBF4+WRF[+ZRF4+XBF]2-XBF'", 10, 90)
    end_record
  end
end

Penrose.new
