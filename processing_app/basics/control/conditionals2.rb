#!/usr/bin/env jruby
require 'propane'
# We extend the language of conditionals by adding the
# keyword "elsif". This allows conditionals to ask
# two or more sequential questions, each with a different
# action.
class Conditionals2 < Propane::App

  def setup
    sketch_title 'Conditionals 2'
    background 0
    2.step(by: 2, to: width - 2) do |i|
      # If 'i' divides by 20 with no remainder
      # draw the first line..
      # else if 'i' divides by 10 with no remainder
      # draw second line, else draw third line
      if (i % 20).zero?
        stroke 255
        line i, 80, i, height / 2
      elsif (i % 10).zero?
        stroke 153
        line i, 20, i, 180
      else
        stroke 102
        line i, height / 2, i, height - 20
      end
    end
  end

  def settings
    size 640, 360
  end
end

Conditionals2.new
