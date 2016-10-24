#!/usr/bin/env jruby
# coding: utf-8
require 'propane'

## Circles by Bárbara Almeida
##  A fork of Circle through 3 points by Bárbara Almeida.
## Draw circles from 3 points moving on smooth random trajectories.
## https://www.openprocessing.org/sketch/211167

## Propane version by Jérémy Laviole - @poqudrof

class Circles < Propane::App

  def settings
    size(800, 600, P3D)
  end
  
  ## To be overriden by the Presentation Code.
  def setup
    colorMode(HSB, 360, 100, 100, 100);
    @c = random(360);

    @points = []
    3.times { @points << Points.new(random(width),random(height)) }

    background 0
    @setup_done = true
  end

  def draw
    fill(0, 0, 0);
    noStroke

    if (frameCount % 8000 == 0)
      rect(0, 0, width, height);
    end
    
    @points.each do |point|
      ##change direction sometimes  
      point.setDir random(-Propane::PConstants::PI, Propane::PConstants::PI) if (random(1) > 0.96)
      point.update
      point.checkEdges
    end

    ## set the style of the circle
    @dc = Propane::PApplet::map(millis(), 0, 150000, 0, 360) ## slowly changes hue
    stroke((@c + @dc) % 360, 50, 100, 5)
    noFill
  
  ## verifies if there is a circle and draw it
    
    det = (@points[0].p.x * @points[1].p.y)  + (@points[1].p.x * @points[2].p.y) + (@points[2].p.x * @points[0].p.y);

    det -= (@points[0].p.y * @points[1].p.x)  + (@points[1].p.y * @points[2].p.x) + (@points[2].p.y * @points[0].p.x);


    draw_circle @points if Propane::PApplet::abs(det) > 50
  end


  def draw_circle(pts)

    ## find the midpoints of 2 sides
    mp = []
    mp[0] = midpoint(pts[0].p, pts[1].p);
    mp[1] = midpoint(pts[1].p, pts[2].p); 

    center_point = center(mp);   ## find the center of the circle
    r = dist(center_point.x, center_point.y, pts[2].p.x, pts[2].p.y);  ##calculate the radius
      
    ellipse(center_point.x, center_point.y, 2*r, 2*r); ## if not collinear display circle  
  end

  def midpoint(a, b)
    d = dist(a.x, a.y, b.x, b.y); ## distance AB
    theta = atan2(b.y - a.y, b.x - a.x); ## inclination of AB
    p = Propane::PVector.new(a.x + d/2*  Propane::PApplet::cos(theta),
                    a.y + d/2* Propane::PApplet::sin(theta), # midpoint
                    theta - Propane::PConstants::HALF_PI);  #inclination of the bissecteur
    return p
  end

  def center(mid_point)
    eq = []

    ## equation of the first bissector (ax - y =  -b)       
    mid_point.each do |mp|
      a = tan mp.z
      eq << Propane::PVector.new(a,
                                   -1,
                                   -1*(mp.y - mp.x*a))
    end

    ## calculate x and y coordinates of the center of the circle
    ox = (eq[1].y * eq[0].z - eq[0].y * eq[1].z) /
         (eq[0].x * eq[1].y - eq[1].x * eq[0].y);
    oy =  (eq[0].x * eq[1].z - eq[1].x * eq[0].z) /
          (eq[0].x * eq[1].y - eq[1].x * eq[0].y);
    return Propane::PVector.new(ox,oy);
  end
end


class Points

  include Propane::Proxy
  attr_accessor :p, :velocity, :acceleration
  
  def initialize(x, y)
    @p = Propane::PVector.new(x, y, 1)
    @velocity = Propane::PVector.new(0, 0, 0);
    @acceleration = Propane::PVector.new($app.random(1), $app.random(1), 0)
  end

  # change direction
  def setDir(angle) 
    ## direction of the acceleration is defined by the new angle
    acceleration.set(Propane::PApplet::cos(angle), Propane::PApplet::sin(angle), 0); 
    
    ## magnitude of the acceleration is proportional to the angle between acceleration and velocity
    acceleration.normalize
    dif = Propane::PVector::angleBetween(acceleration, velocity)
    dif = Propane::PApplet::map(dif, 0, Propane::PConstants::PI, 0.1, 0.001)
    acceleration.mult(dif);
  end

  ## update position
  def update
    velocity.add(acceleration);
    velocity.limit(1.5);    
    p.add(velocity);
  end
  
  def checkEdges
    p.x = constrain(p.x, 0, $app.width)
    p.y = constrain(p.y, 0, $app.height)
  end
end

Circles.new
