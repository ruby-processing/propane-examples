#!/usr/bin/env jruby
require 'propane'
require 'ruby_wordcram'
# firstnames is a WordCram of the most popular first names from
# the 1990 US Census.  Predictably, males are blue, and females
# are pink.  It also shows one way you can use a custom WordColorer.
# See firstnamesUsingSubclasses, in examples/OtherExamples, for another.
#
# When you're parsing the names data, you know whether each word
# is a male or female name.  To take advantage of this, the sketch
# creates a Word object, and pre-sets its color to blue or pink,
# via the set_color method (which fortunately returns the object).
#
# Names collected from http://www.census.gov/genealogy/names
# Minya Nouvelle font from http://www.1001fonts.com/font_details.html?font_id=59
class FirstNamesReset < Propane::App
  attr_reader :names, :wc, :reset

  def setup
    sketch_title 'US Male and Female First Names'
    @names = File.readlines(data_path('names.txt')).map do |line|
      name, frequency, sex = line.split
      col = 'f' == sex ? color('#f36d91') : color('#476dd5')
      Word.new(name, frequency.to_f).set_color(col)
    end
    @reset = true
    make_word_cram
  end

  def make_word_cram
    # NB: see cast to java array
    @wc = WordCram.new(self)
    .from_words(names.to_java(Word))
    .with_font(create_font(data_path('MINYN___.TTF'), 1))
    .sized_by_weight(12, 60)
  end

  def draw
    background 255 if reset
    @reset = false
    if wc.has_more
      wc.draw_next
    else
      puts 'done'
      no_loop
    end
  end

  def mouse_clicked
    make_word_cram
    @reset = true
    loop
  end

  def settings
    size(800, 600)
  end
end

FirstNamesReset.new
