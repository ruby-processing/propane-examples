#!/usr/bin/env jruby
# Hooky class demonstrates how to use the post_initialize hook, creating three
# sketches on a single thread in propane
require 'propane'

class Hooky < Propane::App
  attr_reader :back, :title

  def setup
    sketch_title title
  end

  def post_initialize(args)
    @back = args.fetch(:back_color)
    @title = args.fetch(:title)
  end

  def settings
    size 200, 200
  end

  def draw
    background(color(back))
  end
end

colors = %w[#ff0000 #00ff00 #0000ff].freeze
title = %w[one two three].freeze
opt_values = colors.zip(title)

options = opt_values.flat_map { |values| [back_color: values[0], title: values[1]] }
options.each do |opts|
  Hooky.new(opts)
end
