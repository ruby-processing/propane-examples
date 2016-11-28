#!/usr/bin/env jruby
require 'propane'
# Wolfram Cellular Automata
# by Daniel Shiffman.
# see one example at http://en.wikipedia.org/wiki/Rule_30
# where current pattern	 111 110	101	100	011	010	001	000
# new state for center cell	0	0	0	1	1	1	1	0
# Simple demonstration of a Wolfram 1-dimensional cellular automata
# When the system reaches bottom of the window, it restarts with a new ruleset
# Mouse click restarts as well.
class Wolfram < Propane::App
  load_library :ca
  # An instance object to describe the Wolfram basic Cellular Automata
  attr_reader :ca

  def setup
    sketch_title 'Wolfram'
    frameRate(30)
    background(0)
    ruleset = [0, 1, 0, 1, 1, 0, 1, 0] # An initial rule system
    @ca = CA.new(ruleset) # Initialize CA
  end

  def draw
    ca.render    # Draw the CA
    ca.generate  # Generate the next level
    # If we're done, clear the screen, pick a new ruleset and restart
    init! if ca.finished?
  end

  def settings
    size(640, 360, P2D)
  end

  def init!
    background(0)
    ca.randomize
    ca.restart
  end

  def mouse_pressed
    init!
  end
end

Wolfram.new
