#!/usr/bin/env jruby

require 'propane'
require 'arcball'
# PixelFlow | Copyright (C) 2016 Thomas Diewald - http://thomasdiewald.com
#
# A Processing/Java library for high performance GPU-Computing (GLSL).
# MIT License: https://opensource.org/licenses/MIT
#
class PoissonSampling2D < Propane::App
  load_library :pixel_flow
  java_import 'com.thomasdiewald.pixelflow.java.sampling.PoissonSample'
  java_import 'com.thomasdiewald.pixelflow.java.sampling.PoissonDiscSamping2D'
  attr_reader :samples, :display_radius

  def settings
    size(1280, 720, P2D)
    smooth(16)
  end

  def setup
    sketch_title 'Poisson Sampling 2D'
    @display_radius = true
    generate_poisson_sampling2d
  end

  def generate_poisson_sampling2d
    # create an anonymous class instance in JRuby that implements the java
    # abstract class PoissonDiscSamping2D
    pds = Class.new(PoissonDiscSamping2D) do
      def newInstance(x, y, r, rcollision)
        PoissonSample.new(x, y, r, rcollision)
      end
    end.new
    bounds = [0, 0, 0, width, height, 0]
    rmin = 2
    rmax = 25
    roff = 0.5
    new_points = 100
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    pds.setRandomSeed(rand(0..10_0000))
    pds.generatePoissonSampling2D(bounds, rmin, rmax, roff, new_points)
    @samples = pds.samples
    time = Process.clock_gettime(Process::CLOCK_MONOTONIC) - start
    puts("poisson samples 2D generated")
    puts("    time: #{(time * 1000).floor}ms")
    puts("    count: #{samples.size}")
  end

  def draw
    background(64)
    samples.each do |sample|
      px = sample.x
      py = sample.y
      pr = sample.rad
      if display_radius
        stroke(255)
        stroke_weight(0.5)
        fill(255)
        no_stroke
        ellipse(px, py, pr * 2, pr * 2)
      else
        stroke(255)
        stroke_weight(2)
        point(px, py)
      end
    end
  end

  def key_released
    case key
    when ' '
      @display_radius = !display_radius
    when 'r'
      generate_poisson_sampling2d
    end
  end
end

PoissonSampling2D.new
