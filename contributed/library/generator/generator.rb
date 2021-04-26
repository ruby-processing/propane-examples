# frozen_string_literal: true

# Noise Generator
class Generator
  include SmoothNoise
  attr_reader :nx, :ny, :nz, :remap1, :remap2

  R = 6
  RR = 1

  def initialize(phi, theta)
    base = R + RR * Math.cos(phi)
    tx = base * Math.cos(theta)
    ty = base * Math.sin(theta)
    tz = RR * Math.sin(phi)
    @nx = MathTool.norm(tx, 0.0, R + RR)
    @ny = MathTool.norm(ty, 0.0, R + RR)
    @nz = MathTool.norm(tz, 0.0, RR)
    @remap1 = ->(a, b, c) { ((SmoothNoise.noise(a, b, c) + 1) * 128).floor }
    @remap2 = ->(a, b) { ((SmoothNoise.noise(a, b) + 1) * 128).floor }
  end

  def noisef(time)
    remap2.call(remap1.call(nx, ny, nz), time)
  end
end
