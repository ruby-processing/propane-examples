#!/usr/bin/env jruby
require 'propane'
# Rotate 1.
#
# Rotating simultaneously in the X and Y axis.
# Transformation functions such as rotate() are additive.
# Successively calling rotate(1.0) and rotate(2.0)
# is equivalent to calling rotate(3.0).
class Rotate < Propane::App
  # Rotate.
  #
  # Rotating a square around the Z axis. To get the results
  # you expect, send the rotate function angle parameters that are
  # values between 0 and PI*2 (TAU which is roughly 6.28). If you prefer to
  # think about angles as degrees (0-360), you can use the radians
  # method to convert your values. For example: scale(90.radians)
  # is identical to the statement scale(PI/2).

  # Notice in ruby everything is an object, so we can chain stuff
  # check it out using irb to see what you get with Time.now
  # Time.now.sec and finally Time.now.sec.even? isn't ruby just wonderful
  def setup
    sketch_title 'Rotate'
    no_stroke
    fill 255
    frame_rate 30
    rect_mode CENTER
    @angle = 0.0
    @cosine = 0.0
    @jitter = 0.0
  end

  def draw
    background 51
    @jitter = rand(-0.1..0.1) if Time.now.sec.even?
    @angle += @jitter
    translate width / 2, height / 2
    rotate cos(@angle)
    rect 0, 0, 180, 180
  end

  def settings
    size 640, 360
  end
end

Rotate.new
