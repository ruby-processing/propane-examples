#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
# Letters. Hit any key.
#
require 'propane'

LETTERS = ('A'..'Z').to_a + ('0'..'9').to_a  + ('a'..'z').to_a

# Draws letters to the screen. This requires loading a font,
# setting the font, and then drawing the letters.
class Letters < Propane::App

  def settings
    size 640, 360
  end

  def setup
    sketch_title 'Letters'
    @font = create_font 'Georgia', 24
    text_font @font
    text_align CENTER, CENTER
  end

  def draw
    background 0
    translate 24, 32
    x, y = 0.0, 0.0
    gap = 30
    # ranges -> arrays -> joined!
    LETTERS.each do |letter|
      fill 255
      fill 204, 204, 0 if letter =~ /[AEIOU]/
      fill 0, 204, 204 if letter =~ /[aeiou]/
      fill 153 if letter =~ /[0-9]/
      fill 255, 100, 0 if key_pressed? && (letter.downcase.eql? key)
      fill 0, 100, 255 if key_pressed? && (letter.upcase.eql? key)
      text letter, x, y
      x += gap
      if x > width - 30
        x = 0
        y += gap
      end
    end
  end
end

Letters.new
