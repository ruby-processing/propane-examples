#!/usr/bin/env jruby
require 'propane'
require_relative 'shapes/square'
require_relative 'shapes/circle2.rb'

class Polymorphism2 < Propane::App
# Learning Processing
# Daniel Shiffman
# http://www.learningprocessing.com

# Example 22-2: Polymorphism

# One array of Shapes, in ruby we don't need polymorphism to achieve that,
# this is a JRubyArt port. Introducing the hook method,
# keyword args and the post_initialization hook for flexible inheritance.
# Important change we only really need to know run method initialization of
# color is also really irrelevant save showing how to use hook.

attr_reader :shps

def setup
sketch_title 'Polymorphism'
@shps = []
30.times do
if rand < 0.5
shps << Circle.new(x: 320, y: 180, r: 32)
else
shps << Square.new(x: 320, y: 180, r: 32)
end
end
end

def draw
background(255)
shps.each(&:run)
end

def settings
size(480, 270)
end
end

Polymorphism2.new