#!/usr/bin/env jruby -v -W2
# frozen_string_literal: true
require 'propane'
require 'arcball'
# Esfera
# by David Pena.
# Somewhat re-factored to demonstrate JRubyArt features, including ArcBall,
# use of Forwardable, and Factory Module
# by Martin Prout
# Distribucion aleatoria uniforme sobre la superficie de una esfera.
#
class Esfera < Propane::App
  load_library :simplex_noise
  QUANTITY = 16_000
  SN = SimplexNoise
  attr_reader :orb, :phi, :radius, :rx, :ry

  # signature-specific aliases for overloaded methods
  java_alias :background_int, :background, [Java::int]
  java_alias :fill_int, :fill, [Java::int]
  java_alias :stroke_int, :stroke, [Java::int]
  java_alias :stroke_float_float, :stroke, [Java::float, Java::float]

  def settings
    size(800, 600, P3D)
    no_smooth
  end

  def setup
    sketch_title 'Esfera'
    Processing::ArcBall.init(self, width / 2.0, height / 2.0)
    @rx = 0
    @ry = 0
    @radius = height / 3.5
    @orb = HairyOrb.new(radius)
    QUANTITY.times do
      orb << HairFactory.create_hair(radius)
    end
  end

  def draw
    background_int(0)
    fill_int 0
    no_stroke
    sphere(radius)
    orb.render
    # puts(frame_rate) if (frame_count % 10 == 0)
  end
end

Esfera.new

require 'forwardable'
# HairOrb class uses Forwardable to implement require bits of Enumerable
class HairyOrb
  include Propane::Proxy, Math
  extend Enumerable
  extend Forwardable
  def_delegators(:@hairs, :each, :<<)
  attr_reader :hairs, :radius

  def initialize(radius)
    @radius = radius
    @hairs = []
  end

  def render
    each do |hair|
      off = (Esfera::SN.noise(100, sin(hair.phi), millis * 0.0005) - 0.5) * 0.3
      offb = (Esfera::SN.noise(100, cos(hair.z) * 0.011, millis * 0.0007) - 0.5) * 0.3
      thetaff = hair.theta + off
      costhetaff = cos(thetaff)
      coshairtheta = cos(hair.theta)
      phff = hair.phi + offb
      x = radius * coshairtheta * cos(hair.phi)
      y = radius * coshairtheta * sin(hair.phi)
      za = radius * sin(hair.theta)
      xo = radius * costhetaff * cos(phff)
      yo = radius * costhetaff * sin(phff)
      zo = radius * sin(thetaff)
      xb, yb, zb = xo * hair.len, yo * hair.len, zo * hair.len
      stroke_weight(1)
      begin_shape(PConstants::LINES)
      stroke_int(0)
      vertex(x, y, za)
      stroke_float_float(200, 150)
      vertex(xb, yb, zb)
      end_shape
    end
  end
end

# Hair factory can create anonymous instances of Hair Struct
module HairFactory
  Hair = Struct.new(:z, :phi, :len, :theta)

  def self.create_hair(radius)
    z = rand(-radius..radius)
    phi = rand(0..Math::PI * 2)
    len = rand(1.15..1.2)
    theta = Math.asin(z / radius)
    Hair.new(z, phi, len, theta)
  end
end
