
module Olap
  def self.overlaps(x, y, point_x, point_y)
    Math.hypot(x - point_x, y - point_y) < RADIUS
  end
end


class Curve
  include Propane::Proxy
  include Olap
  attr_accessor :x1, :y1, :c1x, :c1y, :c2x, :c2y, :x2, :y2

  def initialize
    @x1, @y1, @x2, @y2 = X1, Y1, X2, Y2
    set_control_points(X1 + 30, Y1, X2 - 30, Y2)
  end

  def contains(x, y)
    return :one if Olap.overlaps(x1, y1, x, y)
    return :two if Olap.overlaps(x2, y2, x, y)
  end

  def all_points
    return x1, y1, c1x, c1y, c2x, c2y, x2, y2
  end

  def control_points
    return c1x, c1y, c2x, c2y
  end

  def set_control_points(*points)
    @c1x, @c1y, @c2x, @c2y = *points
  end

  def draw
    bezier(*all_points)
    oval x1, y1, 3, 3
    oval x2, y2, 3, 3
  end

  def print_equation(id)
    pt = all_points.map(&:to_i)
    puts ''
    puts format('*** line #%s ***', id)
    xformat = 'x = (1-t)^3 %s + 3(1-t)^2 t%s + 3(1-t)t^2 %s + t^3 %s'
    yformat = 'y = -1 * ((1-t)^3 %s + 3(1-t)^2 t%s + 3(1-t)t^2 %s + t^3 %s'
    puts format(xformat, pt[0], pt[2], pt[4], pt[6])
    puts format(yformat, pt[1], pt[3], pt[5], pt[7])
    puts ''
  end
end
