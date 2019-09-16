#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
require 'socket'
# Starts a network client that connects to a server on port 80,
# sends an HTTP 1.0 GET request, and prints the results.

class HTTPClient < Propane::App
  def settings
    size 200, 200
  end

  def setup
    sketch_title 'TCPSocket'
    host = 'www.ucla.edu'
    port = 80
    s = TCPSocket.open host, port
    s.send "GET / HTTP/1.1\r\n", 0
    s.puts "\r\n"
    while line = s.gets
      puts line.chop
    end
    s.close
  end
end

HTTPClient.new
