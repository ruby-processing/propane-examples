#!/usr/bin/env jruby
require 'propane'
# Statements and Comments.
#
# Statements are the elements that make up programs.
#
# Comments are used for making notes to help people better understand programs.
# A comment begins with a "#" in Ruby.
class StatementsComments < Propane::App

  def settings
    # how large to make the window.
    # Each function statement has zero or more parameters.
    # Parameters are data passed into the function
    # and used as values for specifying what the computer will do.
    size 640, 360
  end

  def setup
    sketch_title 'Statements Comments'
    # The background function is a statement that tells the computer
    # which color to make the background of the window
    background 102
  end
end

StatementsComments.new
