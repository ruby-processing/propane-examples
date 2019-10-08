#!/usr/bin/env jruby -w
# frozen_string_literal: true

require 'propane'
# Earth model with bump mapping, specular texture and dynamic cloud layer.
# Adapted from the THREE.js tutorial to processing by Andres Colubri,
# translated to propane by Martin Prout:
# http://learningthreejs.com/blog/2013/09/16/how-to-make-the-earth-in-webgl/
class BlueMarble < Propane::App
  attr_reader :earth, :clouds, :earth_shader, :cloud_shader, :earth_rotation
  attr_reader :clouds_rotation, :target_angle, :shaders

  SHADERS = %w[EarthFrag.glsl EarthVert.glsl CloudFrag.glsl CloudVert.glsl].freeze
  SHADER_NAME = %i[earth_frag earth_vert cloud_frag cloud_vert].freeze
  IMAGES = %w[earthmap1k earthcloudmap earthcloudmaptrans earthbump1k earthspec1k].freeze
  IMAGE_NAME = %i[earth_tex cloud_tex alpha_tex bump_map spec_map].freeze

  def setup
    sketch_title 'Blue Marble'
    @earth_rotation = 0
    @clouds_rotation = 0
    glsl_files = SHADERS.map { |shade| data_path(shade) }
    @shaders = SHADER_NAME.zip(glsl_files.to_java(:string)).to_h
    images = IMAGES.map { |img| load_image(data_path("#{img}.jpg")) }
    textures = IMAGE_NAME.zip(images).to_h
    @earth_shader = init_shader(:earth_frag, :earth_vert).tap do |shp|
      shp.set('texMap', textures[:earth_tex])
      shp.set('bumpMap', textures[:bump_map])
      shp.set('specularMap', textures[:spec_map])
      shp.set('bumpScale', 0.05)
    end
    @cloud_shader = init_shader(:cloud_frag, :cloud_vert).tap do |shp|
      shp.set('texMap', textures[:cloud_tex])
      shp.set('alphaMap', textures[:alpha_tex])
    end
    @earth = create_sphere(200).tap do |shp|
      shp.set_stroke(false)
      shp.set_specular(color(125))
      shp.set_shininess(10)
    end
    @clouds = create_sphere(201).tap { |shp| shp.set_stroke(false) }
  end

  def create_sphere(dim)
    create_shape(SPHERE, dim)
  end

  def init_shader(frag, vert)
    load_shader(shaders[frag], shaders[vert])
  end

  def draw
    background(0)
    translate(width / 2, height / 2)
    point_light(255, 255, 255, 300, 0, 500)
    target_angle = map1d(mouse_x, (0..width), (0..TWO_PI))
    @earth_rotation += 0.05 * (target_angle - earth_rotation)
    shader(earth_shader)
    push_matrix
    rotate_y(earth_rotation)
    shape(earth)
    pop_matrix
    shader(cloud_shader)
    push_matrix
    rotate_y(earth_rotation + clouds_rotation)
    shape(clouds)
    pop_matrix
    @clouds_rotation += 0.001
  end

  def settings
    size(600, 600, P3D)
  end
end

BlueMarble.new
