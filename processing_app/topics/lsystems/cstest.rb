#!/usr/bin/env jruby
require 'propane'

class CSTest < Propane::App
  ###########################
  # cstest.rb (use jruby ..
  # test of cs_grammar library
  ###########################
  load_library 'cs_grammar'

  def setup
    sketch_title 'Context Sensitive Test'
    background 0
    fill(200, 200, 0)
    f = create_font('Arial', 16, true)
    text_font(f)
    no_loop
  end

  def draw
    (0..7).each do |i|
      grammar = Grammar.new(
      'baaaaaa',
      'b<a' => 'b',   # context sensitive rule replace a when preceded by b
      'b' => 'a'
      )
      text grammar.generate(i), 30, i * 25
    end
  end

  def settings
    size 125, 250, FX2D
  end  
end

CSTest.new
