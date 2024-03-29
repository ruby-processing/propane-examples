#!/usr/bin/env jruby
require 'propane'
# The logical operators for AND (&&) and OR (||) are used to
# combine simple relational statements into more complex expressions.
# The NOT (!) operator is used to negate a boolean statement.
class LogicalOperators < Propane::App
  def setup
    sketch_title 'Logical Operators'
    background 156
    op = false
    (5...width).step(5) do |i|
      stroke 0
      # Logical AND
      if (i > 35) && (i < 100)
        line width / 4, i, width / 2, i
        op = false
      end
      stroke 76
      # Logical OR
      if (i <= 35) || (i >= 100)
        line width / 2, i, width, i
        op = true
      end
      # Testing if a boolean value is "true"
      # The expression "if op" is equivalent to "if (op == true)"
      if op
        stroke_weight 2
        stroke 0
        point width / 3, i
      end
      # Testing if a boolean value is "false"
      # The expressions "unless op" or "if !op" are equivalent to "if (op == false)"
      unless op
        stroke_weight 3
        stroke 255
        point width/4, i
      end
      stroke_weight 1
    end
  end

  def settings
    size 640, 360
  end
end

LogicalOperators.new
