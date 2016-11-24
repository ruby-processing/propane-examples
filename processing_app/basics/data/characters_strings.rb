#!/usr/bin/env jruby
require 'propane'
# Characters Strings.
#
# The character datatype, abbreviated as char, stores letters and
# symbols in the Unicode format, a coding system developed to support
# a variety of world languages. Characters are distinguished from other
# symbols by putting them between single quotes ('P').<br />
# <br />
# A string is a sequence of characters. A string is noted by surrounding
# a group of letters with double quotes ("Processing").
# Chars and strings are most often used with the keyboard methods,
# to display text to the screen, and to load images or files.<br />
# <br />
# The String datatype must be capitalized because it is a complex datatype.
# A String is actually a class with its own methods, some of which are
# featured below.
class CharactersStrings < Propane::App

  attr_reader :letter, :words

  def setup
    sketch_title 'Characters Strings'
    @words = "Begin..."
    # Create the font
    text_font create_font("Georgia", 36)
  end

  def draw
    background(0) # Set background to black
    # Draw the letter to the center of the screen
    text_size(14)
    text("Click on the program, then type to add to the String", 50, 50)
    text("Current key: #{letter}", 50, 70)
    text("The String is #{words.length} characters long", 50, 90)
    text_size(36)
    text(words, 50, 120, 540, 300)
  end

  def key_pressed
    # The variable "key" always contains the value
    # of the most recent key pressed.
    if (('A'..'z').include?(key) || key == ' ')
      @letter = key
      @words = words + key
      puts(key)
    end
  end

  def settings
    size 640, 360
  end
end

CharactersStrings.new
