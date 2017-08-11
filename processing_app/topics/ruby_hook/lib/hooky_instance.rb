#!/usr/bin/env jruby
# Hooky class demonstrates how to use the post_initialize hook with java
# thread
require 'propane'

class Hooky < Propane::App
  include java.lang.Runnable
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

  def run
    puts "starting #{title}"
  end
end
