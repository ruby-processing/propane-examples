#!/usr/bin/env jruby -v -W2

############################
# Use mouse drag to rotate
# The arcball. Use mousewheel
# to zoom. Hold down x, y, z
# to constrain rotation axis.
############################

require 'propane'

class SelectFile < Propane::App

  load_library :file_chooser
  ###########
  # Example Native File Chooser using vanilla processing
  # select_input, and file_selected
  ###########

  def setup
    size 200, 100
    # java_signature 'void selectInput(String, String)'
    select_input('Select a File', 'file_selected')
  end

  #  signature 'void file_selected(java.io.File file)'
  def file_selected(file)
    puts file.get_absolute_path unless file.nil?
  end
end

SelectFile.new
