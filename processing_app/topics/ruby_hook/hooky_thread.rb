#!/usr/bin/env jruby
# Creating threaded instance of Hooky maty not be mush use because we create a
# global $app
require_relative 'lib/hooky_instance'

colors = %w[#ff0000 #00ff00 #0000ff].freeze
title = %w[one two three].freeze
opt_values = colors.zip(title)

options = opt_values.flat_map { |values| [back_color: values[0], title: values[1]] }
options.each do |opts|
  java.lang.Thread.new(Hooky.new(opts)).start
end
