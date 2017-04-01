#!/usr/bin/env jruby
require 'propane'
require 'toxiclibs'

class PaletteGenerator < Propane::App

  attr_reader :mono, :complement

  def settings
    size 500, 400
  end

  def setup
    sketch_title 'Monochrome and Complementary Blue Swatches'
    @mono = Toxi::MonochromeTheoryStrategy.new.create_list_from_color(TColor::BLUE)
    @complement = Toxi::ComplementaryStrategy.new.create_list_from_color(TColor::BLUE)
    render_palette(mono)
    render_palette(complement, 200)
  end

  def draw
  end

  def key_pressed
    File.open(data_path('palette.rb'), 'w') do |file|
      file.write("# Monochrome Blue\n")
      file.write(mono.to_ruby_string)
      file.write("# Complement Blue\n")
      file.write(complement.to_ruby_string)
    end
  end

  def render_palette(palette, ypos = 0)
    x = 0
    palette.each do |col|
      fill col.toARGB
      rect x, ypos, x + 100, 100
      x += 100
    end
  end
end

PaletteGenerator.new
