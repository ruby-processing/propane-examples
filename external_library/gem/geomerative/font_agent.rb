# frozen_literal: true
# FontAgent class handles motion and display
class FontAgent
  include Propane::Proxy
  attr_reader :loc, :mot

  def initialize(location:)
    @loc = location
    @mot = 0
  end

  def motion
    noise_scale = map1d(mouse_x, (0..width), (0.001..0.01))
    noise_z = map1d(mouse_x, (0..height), (frame_count * 0.0003..frame_count * 0.02))
    @mot = noise(loc.x * noise_scale * noise_z, loc.y * noise_scale * noise_z) * 53
  end

  def display(step:)
    no_stroke
    fill(255, 53)
    ellipse(loc.x, loc.y, mot + step, mot + step)
  end
end
