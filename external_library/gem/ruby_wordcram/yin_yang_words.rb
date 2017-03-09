#!/usr/bin/env jruby
require 'propane'
require 'ruby_wordcram'

class YinYangWords < Propane::App

  def setup
    sketch_title 'Yin Yang Words'
    background 255
    image = load_image(data_path('yinyang.png'))
    image.resize(width, height)
    image_shape = ImageShaper.new.shape(image, color('#000000'))
    placer = ShapeBasedPlacer.new(image_shape)
    WordCram.new(self)
            .from_words(repeat_word('flexible', 500).to_java(Word))
            .with_placer(placer)
            .with_nudger(placer)
            .sized_by_weight(4, 40)
            .angled_at(0)
            .with_color(color('#F5B502'))
            .draw_all
    image_shape = ImageShaper.new.shape(image, color('#ffffff'))
    placer = ShapeBasedPlacer.new(image_shape)
    WordCram.new(self)
            .from_words(repeat_word('usable', 500).to_java(Word))
            .with_placer(placer)
            .with_nudger(placer)
            .sized_by_weight(4, 40)
            .angled_at(0)
            .with_color(color('#782CAF'))
            .draw_all
   end

  def repeat_word(word, times)
    (0..times).map do
      # Give the words a random weight, so they're sized differently.
      Word.new(word, rand)
     end
  end

  def settings
    size(600, 600)
  end
end

YinYangWords.new
