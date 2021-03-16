#!/usr/bin/env jruby
require 'propane'
require 'ruby_wordcram'

WEB = %w(#0033ff #0055ff #0088ff #00bbff #00ffdd).freeze
LETTERS = ('A'..'Z').to_a

class RenderToSVG < Propane::App

  def setup
    sketch_title 'Render SVG'
    background(255)
    count = 0
    words = LETTERS.reverse.map do |letter|
      weight = norm_strict(count, 0, LETTERS.length)
      count += 1
      Word.new(letter, weight)
    end
    colors = WEB.map{ |web| color(web) } # map color strings to color int
    @wc = WordCram.new(self)
                  .from_words(words.to_java(Word))
                  .to_svg(data_path('letters.svg'), width, height)
                  .with_colors(*colors)
                  .sized_by_weight(150, 10)
                  .draw_all
    puts 'Done rendering the SVG.'
    puts 'loading the svg...'
    sh = load_shape(data_path('letters.svg'))
    background 255
    shape(sh, 0, 0)
  end

  def settings
    size 800, 500
  end
end

RenderToSVG.new
