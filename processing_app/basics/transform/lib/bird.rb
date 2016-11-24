# frozen_string_literal: true
# encapsulate Bird behaviour
class Bird
  include Propane::Proxy 	# mixin Processing commands
  attr_accessor :offset_x, :offset_y, :offset_z
  attr_accessor :w, :h
  attr_accessor :body_fill, :wing_fill
  attr_accessor :ang, :ang2, :ang3, :ang4
  attr_accessor :radius_x, :radius_y, :radius_z
  attr_accessor :rot_x, :rot_y, :rot_z
  attr_accessor :flap_speed
  attr_accessor :rot_speed

  def initialize(offset_x, offset_y, offset_z, w, h)
    defaults
    @offset_x, @offset_y, @offset_z = offset_x, offset_y, offset_z
    @w, @h = w, h
  end

  def defaults
    @ang, @ang2, @ang3, @ang4 = 0.0, 0.0, 0.0, 0.0
    @body_fill, @wing_fill = color(153), color(204)
    @flap_speed = 0.4
    @rot_speed = 0.1
    @radius_x, @radius_y, @radius_z = 120.0, 200.0, 700.0
  end

  def set_flight(radius_x, radius_y, radius_z, rot_x, rot_y, rot_z)
    @radius_x, @radius_y, @radius_z = radius_x, radius_y, radius_z
    @rot_x, @rot_y, @rot_z = rot_x, rot_y, rot_z
    return self  # return self means we can chain methods
  end

  def set_wing_speed(flap_speed)
    @flap_speed = flap_speed
    return self  # return self means we can chain methods
  end

  def set_rot_speed(rot_speed)
    @rot_speed = rot_speed
    return self  # return self means we can chain methods
  end

  def fly
    push_matrix
    px = sin(@ang3.radians) * @radius_x
    py = cos(@ang3.radians) * @radius_y
    pz = sin(@ang4.radians) * @radius_z
    translate @offset_x + px,
    @offset_y + py,
    @offset_z + pz
    rotate_x sin(@ang2.radians) * @rot_x
    rotate_y sin(@ang2.radians) * @rot_y
    rotate_z sin(@ang2.radians) * @rot_z
    fill @body_fill
    box @w/5, @h, @w/5
    fill @wing_fill
    push_matrix
    rotate_y sin(@ang.radians) * 20
    rect 0, -@h/2, @w, @h
    pop_matrix
    push_matrix
    rotate_y sin(@ang.radians) * -20
    rect -@w, -@h/2, @w, @h
    pop_matrix
    @ang += @flap_speed
    @flap_speed *= -1 if @ang > PI || @ang < -PI
    @ang2 += @rot_speed
    @ang3 += 1.25
    @ang4 += 0.55
    pop_matrix
  end
end
