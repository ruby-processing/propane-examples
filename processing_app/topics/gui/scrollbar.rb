#!/usr/bin/env jruby
require 'propane'
# Scrollbar.
#
# Move the scrollbars left and right to change the positions of the images.
class Scrollbar < Propane::App
  attr_reader :hs1, :hs2, :img1, :img2

  def settings
    size 640, 360
  end

  def setup
    sketch_title 'Scrollbar'
    no_stroke
    @hs1 = HScrollbar.new(height: height / 2 - 8, wd: 16, loose: 16)
    @hs2 = HScrollbar.new(height: height / 2 + 8, wd: 16, loose: 16)
    # Load images
    @img1 = load_image(data_path('seedTop.jpg'))
    @img2 = load_image(data_path('seedBottom.jpg'))
  end

  def draw
    background(255)
    # Get the position of the img1 scrollbar
    # and convert to a value to display the img1 image
    img1_pos = hs1.position - width / 2
    fill(255)
    image(img1, width / 2 - img1.width / 2 + img1_pos * 1.5, 0)
    # Get the position of the img2 scrollbar
    # and convert to a value to display the img2 image
    img2_pos = hs2.position - width / 2
    fill(255)
    image(img2, width / 2 - img2.width / 2 + img2_pos * 1.5, height / 2)
    hs1.update mouse_pressed?
    hs2.update mouse_pressed?
    hs1.display
    hs2.display
    stroke(0)
    line(0, height / 2, width, height / 2)
  end
end

# Scrollbar class (keywords constructor wd is widget handle dimension)
class HScrollbar
  include Propane::Proxy
  attr_reader :swidth, :wd, :xpos, :ypos, :spos, :newspos, :bound_x
  attr_reader :spos_max, :spos_min, :loose, :over, :locked, :ratio, :bound_y
  def initialize(height:, wd:, loose:)
    @swidth = width
    @wd = wd
    widthtoheight = width - wd
    @ratio = width.to_f / widthtoheight
    @xpos = 0
    @ypos = height - wd / 2
    @spos = xpos + swidth / 2 - wd / 2
    @newspos = spos
    @spos_min = xpos
    @spos_max = xpos + swidth - wd
    @loose = loose # how loose/heavy the slider is coupled?
    @bound_x = Boundary.new(xpos, xpos + swidth)
    @bound_y = Boundary.new(ypos, ypos + wd)
  end

  def update(pressed)
    if !pressed
      @locked = false
    else
      @locked = pressed && over_event?
    end
    @newspos = constrain(mouse_x - wd / 2, spos_min, spos_max) if locked
    @spos = spos + (newspos - spos) / loose if (newspos - spos).abs > 1
  end

  def over_event?
    bound_x.include?(mouse_x) && bound_y.include?(mouse_y)
  end

  def display
    no_stroke
    fill(204)
    rect(xpos, ypos, swidth, wd)
    if over || locked
      fill(0, 0, 0)
    else
      fill(102, 102, 102)
    end
    rect(spos, ypos, wd, wd)
  end

  def position
    # Convert spos to be values between
    # 0 and the total width of the scrollbar
    spos * ratio
  end
end

# simple Boundary class
class Boundary
  attr_reader :low, :high

  def initialize(low, high)
    @low, @high = low, high
  end

  def include?(val)
    (low..high).cover? val
  end
end

Scrollbar.new
