#!/usr/bin/env jruby
require 'propane'
require 'ruby_wordcram'
# US Constitution text from http://www.usconstitution.net/const.txt
# Liberation Serif font from RedHat: https://www.redhat.com/promo/fonts/

LETTERS = ('A'..'Z').to_a

class LetterStairCase < Propane::App

  def setup
    sketch_title 'Letter Stair Case'
    background 255
    fill 0
    WordCram.new(self)
    .from_words(load_letters.to_java(Word))
    .angled_at(0)
    .min_shape_size(0) # Make sure "I" always shows up.
    .draw_all
  end

  def load_letters
    count = 0
    letters = LETTERS.map do |letter|
      word = Word.new(letter, 1)
      x = map1d(count, (0..29), (0..width))
      y = map1d(count, (0..29), (0..height))
      count += 1
      word.set_place(x, y)
      word.set_size(35)
    end
  end

  def settings
    size 400, 250
  end
end

LetterStairCase.new
