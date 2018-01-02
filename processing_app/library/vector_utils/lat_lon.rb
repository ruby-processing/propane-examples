#!/usr/bin/env jruby -v -W2

require 'propane'
require 'arcball'
require 'csv'
# Capital name, Latitude and Longitude from csv
class LatLong < Propane::App

  load_library :vector_utils
  # Uses to_cartesian to map lat lon of cities, read from a csv file, on a globe
  def setup
    sketch_title 'Latitude and Longitude'
    noStroke
    textSize(9)
    Processing::ArcBall.init self
  end

  def draw
    background(20)
    lights
    counter = 0
    CSV.foreach(data_path('capitals.csv'), headers: true) do |row|
      lat = row['CapitalLatitude'].to_f
      lon = row['CapitalLongitude'].to_f
      name = row['CapitalName']
      p = VectorUtil.to_cartesian(lat: lat, long: lon, radius: 300)
      push_matrix
      translate(p.x, p.y, p.z)
      polar = VectorUtil.cartesian_to_polar(vec: p)
      rotate_y(polar.y)
      rotate_z(polar.z)
      push_matrix
      fill(255)
      text(name,0,0) if (counter % 3).zero?
      pop_matrix
      box(10, 3, 3)
      pop_matrix
      counter += 1
    end
  end

  def settings
    size(800, 800, P3D)
  end
end

LatLong.new
