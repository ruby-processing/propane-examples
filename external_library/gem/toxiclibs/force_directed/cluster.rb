#
# Copyright (c) 2010 Daniel Shiffman
#
# This demo & library is free software you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation either
# version 2.1 of the License, or (at your option) any later version.
#
# http://creativecommons.org/licenses/LGPL/2.1/
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
class Cluster
  attr_reader :nodes, :diameter, :physics

  # We initialize a with a number of nodes, a diameter, and centerpoint
  def initialize(physics, n, d, center)
    @physics = physics
    @diameter = d
    @nodes = (0..n).map { Node.new(center.add(TVec2D.random_vector)) }
    # Connect all the nodes with a Spring
    nodes[1..nodes.size - 1].each_with_index do |pi, i|
      nodes[0..i].each do |pj|
        physics.add_spring(Physics::VerletSpring2D.new(pi, pj, diameter, 0.01))
      end
    end
  end

  def display
    nodes.each(&:display)
  end
  # This functons connects one cluster to another
  # Each point of one cluster connects to each point of the other cluster
  # The connection is a "VerletMinDistanceSpring"
  # A VerletMinDistanceSpring is a spring which only enforces its rest length if the
  # current distance is less than its rest length. This is handy if you just want to
  # ensure objects are at least a certain distance from each other, but don't
  # care if it's bigger than the enforced minimum.

  def connect(other)
    other_nodes = other.nodes
    nodes.each do |pi|
      other_nodes.each do |pj|
        physics.add_spring(Physics::VerletMinDistanceSpring2D.new(pi, pj, (diameter + other.diameter) * 0.5, 0.05))
      end
    end
  end

  # Draw all the internal connections
  def internal_connections(app)
    app.stroke(200, 0, 0, 80)
    nodes[0..nodes.size - 1].each_with_index do |pi, i|
      nodes[i + 1..nodes.size - 1].each do |pj|
        app.line(pi.x, pi.y, pj.x, pj.y)
      end
    end
  end

  # Draw all the connections between this and another Cluster
  def show_connections(app, other)
    app.stroke(200, 200, 0, 20)
    app.stroke_weight(2)
    other_nodes = other.nodes
    nodes.each do |pi|
      other_nodes[0..other_nodes.size - 1].each do |pj|
        app.line(pi.x, pi.y, pj.x, pj.y)
      end
    end
  end
end
