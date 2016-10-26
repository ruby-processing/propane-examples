#!/usr/bin/env jruby -v -W2
###
# Polyhedrons after sketch by Chinchbug on openprocessing.org
###
Vert = Struct.new(:x, :y, :z) do
  def dist_sq(v)
    (x - v.x) * (x - v.x) + (y - v.y) * (y - v.y) + (z - v.z) * (z - v.z)
  end

  def self.permutations(x, y, z)
    [new(x, y, z), new(z, x, y), new(y, z, x)]
  end
end

PHI = (1 + Math.sqrt(5)) / 2
PHI_SQ = PHI * PHI
PHI_CU = PHI * PHI * PHI
ROOT2 = Math.sqrt(2)
TYPE = "Type Archimedian\nFaces: "

require 'propane'

class Polyhedrons < Propane::App

  attr_reader :verts, :curr_id, :scayl, :ang, :spd, :name, :notes, :off_x, :off_y
  attr_reader :off_z, :len_edge

  def settings
    size(1020, 576, P3D)
    smooth 4
  end

  def setup
    sketch_title 'Polyhedrons'
    smooth 4
    text_size(14)
    # some positional variables for translation
    @off_y = height / 2
    @off_x = width / 2 - 100
    @off_z = -off_y / 8
    # angle and speed for rotation
    @ang = 0.0
    @spd = 0.015
    # set up initial polyhedron
    @verts = []
    @curr_id = 0
    create_poly(curr_id)
  end

  def draw
    # setup the view
    background(200)
    push_matrix
    translate(off_x, off_y, off_z)
    rotate_x(Math.sin(-ang * 0.3) * 0.5)
    rotate_y(ang)
    draw_axis
    # draw the polyhedron
    stroke_weight(0.75)
    stroke(0)
    (0...verts.size).each do |i|
      (i...verts.size).each do |j|
        draw_line(verts[i], verts[j]) if edge?(verts[i], verts[j])
      end
    end
    pop_matrix
    hint(DISABLE_DEPTH_TEST)
    # show some notes
    fill(80, 50, 20)
    text(name, width - 360, 50)
    text(notes, width - 340, 70)
    text('Click to view next polyhedron...',  width - 360, height - 50)
    hint(ENABLE_DEPTH_TEST)
    # bump up the angle for the spin
    @ang += spd
  end

  def mouse_released
    # change the polyhedron
    create_poly(@curr_id += 1)
  end

  def draw_line(v1, v2)
    # Draws an edge line
    line(v1.x * scayl, v1.y * scayl, v1.z * scayl, v2.x * scayl, v2.y * scayl, v2.z * scayl)
  end

  def edge?(v1, v2)
    # had some rounding errors, now a bit more forgiving...
    pres = 1000
    d = v1.dist_sq(v2) + 0.00001
    ((d *  pres).round == (len_edge * len_edge * pres).round)
  end

  def add_verts(x, y, z)
    # adds the requested vert and all 'mirrored' verts
    verts << Vert.new(x, y, z)
    verts << Vert.new(x, y, -z) unless (z == 0.0)
    verts << Vert.new(x, -y, z) unless (y == 0.0)
    verts << Vert.new(x, -y, -z) unless (z == 0.0)
    verts << Vert.new(-x, y, z) unless (x == 0.0)
    verts << Vert.new(-x, y, -z) unless (z == 0.0)
    verts << Vert.new(-x, -y, z) unless (y == 0.0)
    verts << Vert.new(-x, -y, -z) unless (z == 0.0)
  end

  def permutations(x, y, z)
    # adds vertices for all three permutations of x, y, and z
    Vert.permutations(x, y, z).each { |v| add_verts(v.x, v.y, v.z) }
  end

  def draw_axis
    # based off how Sketchup handles their axis
    stroke_weight(0.5)
    stroke(0, 128, 0)
    line(-300, 0, 0, 0, 0, 0)
    stroke(0, 0, 128)
    line(0, -300, 0, 0, 0, 0)
    stroke(128, 0, 0)
    line(0, 0, -300, 0, 0, 0)
    stroke_weight(0.25)
    stroke(0, 128, 0)
    line(300, 0, 0, 0, 0, 0)
    stroke(0, 0, 128)
    line(0, 300, 0, 0, 0, 0)
    stroke(128, 0, 0)
    line(0, 0, 300, 0, 0, 0)
  end

  def create_poly(id)
    # This is where the actual defining of the polyhedrons takes place
    verts.clear # clear out whatever verts are currently defined
    case (id)
    when 0
      @name = 'Cube:'
      @notes = "Type platonic\nFaces: 6 squares\nVertices 8\nEdges 12"
      add_verts(1, 1, 1)
      @len_edge = 2
      @scayl = 140
    when 1
      @name = 'Octohedron:'
      @notes = "Type platonic\nFaces: 8 triangles\nVertices 6\nEdges 12"
      permutations(1, 0, 0)
      @len_edge = ROOT2
      @scayl = 220
    when 2
      @name = 'Dodecahedron:'
      @notes = "Type platonic\nFaces: 12 pentagons\nVertices 20\nEdges 30"
      add_verts(1, 1, 1)
      permutations(0, 1 / PHI, PHI)
      @len_edge = 2 / PHI
      @scayl = 130
    when 3
      @name = 'Icosahedron:'
      @notes = "Type platonic\nFaces: 20 triangles\nVertices 12\nEdges 30"
      permutations(0, 1, PHI)
      @len_edge = 2.0
      @scayl = 120
    when 4
      @name = 'Rhombic Dodecahedron:'
      @notes = "Type Catalan\nFaces: 12 rhombuses\nVertices 14\nEdges 24"
      add_verts(1, 1, 1)
      permutations(0, 0, 2)
      @len_edge = Math.sqrt(3)
      @scayl = 110
    when 5
      @name = 'Rhombic Triacontahedron:'
      @notes = "Type Catalan\nFaces: 30 rhombuses\nVertices 32\nEdges 60"
      add_verts(PHI_SQ, PHI_SQ, PHI_SQ)
      permutations(PHI_SQ, 0, PHI_CU)
      permutations(0, PHI, PHI_CU)
      @len_edge = PHI * Math.sqrt(PHI + 2)
      @scayl = 46
    when 6
      @name = 'Cuboctahedron:'
      @notes = format("%s %d triangles, 6 squares\nVertices 12\nEdges 24", TYPE, 8)
      permutations(1, 0, 1)
      @len_edge = ROOT2
      @scayl = 170
    when 7
      @name = 'Truncated Cube:'
      @notes = format("%s %d triangles, 6 octogons\nVertices 24\nEdges 36", TYPE, 8)
      permutations(ROOT2 - 1, 1, 1)
      @len_edge = 2 * (ROOT2 - 1)
      @scayl = 155
    when 8
      @name = 'Truncated Octahedron:'
      @notes = format("%s %d squares, 8 hexagons\nVertices 24\nEdges 36", TYPE, 6)
      permutations(0, 1, 2)
      permutations(2, 1, 0)
      @len_edge = ROOT2
      @scayl = 100
    when 9
      @name = 'Rhombicuboctahedron:'
      @notes = format("%s %d triangles, 18 squares\nVertices 24\nEdges 48", TYPE, 8)
      permutations(ROOT2 + 1, 1, 1)
      @len_edge = 2
      @scayl = 80
    when 10
      @name = 'Truncated Cuboctahedron:'
      @notes = format("%s %d squares, 8 hexagons, 6 octogons\nVertices 48\nEdges 72", TYPE, 12)
      permutations(ROOT2 + 1, 2 * ROOT2 + 1, 1)
      permutations(ROOT2 + 1, 1, 2 * ROOT2 + 1)
      @len_edge = 2
      @scayl = 50
    when 11
      @name = 'Icosidodecahedron:'
      @notes = format("%s %d triangles, 12 pentagons\nVertices 30\nEdges 60", TYPE, 20)
      permutations(0, 0, 2 * PHI)
      permutations(1, PHI, PHI_SQ)
      @len_edge = 2
      @scayl = 70
    when 12
      @name = 'Truncated Dodecahedron:'
      @notes = format("%s %d triangles, 12 decagons\nVertices 60\nEdges 90", TYPE, 20)
      permutations(0, 1 / PHI, PHI + 2)
      permutations(1 / PHI, PHI, 2 * PHI)
      permutations(PHI, 2, PHI_SQ)
      @len_edge = 2 * (PHI - 1)
      @scayl = 60
    when 13
      @name = 'Truncated Icosahedron:'
      @notes = format("%s %d pentagons, 20 hexagons\nVertices 60\nEdges 90", TYPE, 12)
      permutations(0, 1, 3 * PHI)
      permutations(2, 2 * PHI + 1, PHI)
      permutations(1, PHI + 2, 2 * PHI)
      @len_edge = 2
      @scayl = 45
    when 14
      @name = 'Small Rhombicosidodecahedron:'
      @notes = format("%s %d triangles, 30 squares, 12 pentagons\nVertices 60\nEdges 120", TYPE, 20)
      permutations(1, 1, PHI_CU)
      permutations(PHI_SQ, PHI, 2 * PHI)
      permutations(PHI + 2, 0, PHI_SQ)
      @len_edge = 2
      @scayl = 50
    when 15
      @name = 'Great Rhombicosidodecahedron:'
      @notes = format("%s %d squares, 20 hexagons, 12 decagons\nVertices 120\nEdges 180", TYPE, 30)
      permutations(1 / PHI, 1 / PHI, PHI + 3)
      permutations(2 / PHI, PHI, 2 * PHI + 1)
      permutations(1 / PHI, PHI_SQ, 3 * PHI - 1)
      permutations(2 * PHI - 1, 2, PHI + 2)
      permutations(PHI, 3, 2 * PHI)
      @len_edge = 2 * PHI - 2
      @scayl = 48
    else    # start again
      @curr_id = 0
      create_poly(curr_id)
    end
  end
end

Polyhedrons.new
