#!/usr/bin/env jruby
# frozen_string_literal: true

require 'propane'
#######################################################
# Lindenmayer System in propane by Martin Prout
# snake_kolam.rb using l-systems
#######################################################
class SnakeKolamSketch < Propane::App
  load_library :grammar
  attr_reader :kolam

  def setup
    sketch_title 'Snake Kolam'
    @kolam = SnakeKolam.new width / 8, height * 0.8
    kolam.create_grammar 3 # create grammar from rules
    no_loop
  end

  def draw
    background 0
    stroke_weight 3
    stroke 200
    kolam.render
  end

  def settings
    size 500, 500
  end
end

Turtle = Struct.new(:x, :y, :angle)

# class SnakeKolam
class SnakeKolam
  include Propane::Proxy

  attr_reader :axiom, :start_length, :xpos, :ypos, :grammar, :production, :draw_length, :gen
  DELTA = 90 # degrees

  def initialize(xpos, ypos)
    setup_grammar
    @start_length = 120.0
    @theta = 90 # degrees
    @draw_length = start_length
    @xpos = xpos
    @ypos = ypos
  end

  def setup_grammar
    @axiom = 'FX+F+FX+F'
    @grammar = Grammar.new(
      axiom,
      'X' => 'X-F-F+FX+F+FX-F-F+FX'
    )
  end

  def render # NB not using affine transforms here
    turtle = Turtle.new(xpos, ypos, 0)
    production.scan(/./) do |element|
      case element
      when 'F'
        turtle = draw_line(turtle, draw_length)
      when '+'
        turtle.angle += DELTA
      when '-'
        turtle.angle -= DELTA
      when 'X'
      else
        puts "Character '#{element}' is not in grammar"
      end
    end
  end

  ##############################
  # create grammar from axiom and
  # rules (adjust scale)
  ##############################

  def create_grammar(gen)
    @gen = gen
    @draw_length *= 0.6**gen
    @production = @grammar.generate gen
  end

  private

  ######################################################
  # draws line uDegLut.sing current turtle and length parameters
  # returns a turtle corresponding to the new position
  ######################################################

  def draw_line(turtle, _length)
    x_temp = turtle.x
    y_temp = turtle.y
    turtle.x += draw_length * DegLut.cos(turtle.angle)
    turtle.y += draw_length * DegLut.sin(turtle.angle)
    line(x_temp, y_temp, turtle.x, turtle.y)
    turtle
  end
end

SnakeKolamSketch.new
