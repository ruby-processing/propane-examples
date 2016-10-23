#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
###########
# Example Native File Chooser using vanilla processing
# select_input, and file_selected
###########
class SelectFile < Propane::App
  load_library :file_chooser

  def setup
    sketch_title 'SelectFile'
    # java_signature 'void selectInput(String, String)'
    select_input('Select a File', 'file_selected')
  end

  def settings
    size 200, 100
  end

  #  signature 'void file_selected(java.io.File file)'
  def file_selected(file)
    puts file.get_absolute_path unless file.nil?
  end
end

SelectFile.new
