#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
# Shared Drawing Canvas (Server)
# by Alexander R. Galloway. Translated to JRubyArt by Martin Prout
#
# A server that shares a drawing canvas between two computers.
# In order to open a socket connection, a server must select a
# port on which to listen for incoming clients and through which
# to communicate. Once the socket is established, a client may
# connect to the server and send or receive commands and data.
# Get this program running and then start the Shared Drawing
# Canvas (Client) program so see how they interact.
class SketchServer < Propane::App
  load_library :net

  attr_reader :s

  def settings
    size(450, 255)
  end

  def setup
    sketch_title 'Server'
    background(204)
    stroke(0)
    frame_rate(5) # Slow it down a little
    @s = Server.new(self, 12_345) # Start a simple server on a port
  end

  def draw
    if mouse_pressed?
      # Draw our line
      stroke 255
      line(pmouse_x, pmouse_y, mouse_x, mouse_y)
      # Send mouse coords to other person
      s.write(format("%f %f %f %f\n", pmouse_x, pmouse_y, mouse_x, mouse_y))
    end
    # Receive data from client
    c = s.available
    return if c.nil?
    stroke 255, 0, 0
    input = c.read_string
    # Split input into an array of lines
    data = input.split("\n")
    # Split first line to array of string and convert to array of java float
    coords = data[0].split(' ').map(&:to_f).to_java(:float)
    # Draw line using received coords
    line(*coords)
  end
end

SketchServer.new
