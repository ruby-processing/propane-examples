#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Random Gaussian.
#
# This sketch draws ellipses with x and y locations tied to a gaussian distribution of random numbers.
#
class RandomGaussianSketch < Propane::App
  def setup
    sketch_title 'Random Gaussian'
    background(0)
  end

  def draw
    # Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
    val = random_gaussian
    sd = 60                    # Define a standard deviation
    mean = width  / 2          # Define a mean value (middle of the screen along the x-axis)
    x = (val * sd) + mean      # Scale the gaussian random number by standard deviation and mean
    fill(200, 20)
    no_stroke
    ellipse(x, height / 2, 32, 32)   # Draw an ellipse at our "normal" random location
  end

  def settings
    size(640, 360)
  end
end

RandomGaussianSketch.new
