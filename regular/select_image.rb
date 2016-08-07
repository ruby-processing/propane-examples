#!/usr/bin/env jruby -v -W2

require 'propane'

class SelectImage < Propane::App

  load_library :file_chooser
  ###########
  # Example Native File Chooser using vanilla processing
  # select_input, and file_selected
  ###########
  attr_reader :img

  def settings
    size(400, 200)
  end

  def setup
    sketch_title 'Native File Chooser'
    resizable
    fill 0, 0, 200
    text('Click Window to Load Image', 10, 100)
  end

  def draw
    image(img, 0, 0) unless img.nil?
  end

  def file_selected(selection)
    if selection.nil?
      puts 'Nothing Chosen'
    else
      @img = load_image(selection.get_absolute_path)
      surface.set_size(img.width, img.height)
    end
  end

  def mouse_clicked
    @img = nil
    # java_signature 'void selectInput(String, String)'
    select_input('Select Image File', 'file_selected')
  end
end

SelectImage.new
