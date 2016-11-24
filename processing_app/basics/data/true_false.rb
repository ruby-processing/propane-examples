#!/usr/bin/env jruby
# frozen_string_literal: true
require 'propane'
# Boolean data is one bit of information. True or false.
# It is common to use Booleans with control statements to
# determine the flow of a program. In this example, when the
# boolean value "x" is true, vertical black lines are drawn and when
# the boolean value "x" is false, horizontal gray lines are drawn.
# In Ruby, false and nil are "falsy" ... they are the only things
# that will fail an "if" test. Absolutely everything else passes "if".
class TrueFalse < Propane::App
  def setup
    sketch_title 'True False'
    background 0
    stroke 0
    (1..width).step(2) do |i|
      if i < (width / 2) # Evaluates to true or false, depending on i
        vertical_line(i)
      else
        horizontal_line(i)
      end
    end
  end

  def vertical_line(i)
    stroke 255
    line i, 1, i, height - 1
  end

  def horizontal_line(i)
    stroke 126
    line width / 2, i, width - 2, i
  end

  def settings
    size 200, 200
  end
end

TrueFalse.new
