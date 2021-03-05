require 'propane'
#---------------------------------------------------------
# ShaderToy: https://www.shadertoy.com/view/ltB3WW by tholzer
# Newton fractal with 3 or 4 or 5  symmetry (change #define NEWTON #).
# Press mouse button to change formula constants.
# info:     http://en.wikipedia.org/wiki/Newton_fractal
#---------------------------------------------------------

class NewtonFractal < Propane::App
  attr_reader :last_mouse_position, :mouse_click_state, :mouse_dragged
  attr_reader :newton

  def settings
    size(600, 600, P2D)
  end

  def setup
    sketch_title 'Newton Fractal Shader'
    @mouse_dragged = false
    @mouse_click_state = 0.0
    # Load the shader file from the "data" folder
    @newton = load_shader(data_path('newton_shader.glsl'))
    # Assume the dimension of the window will not change over time
    newton.set('iResolution', width.to_f, height.to_f, 0.0)
    @last_mouse_position = Vec2D.new(mouse_x.to_f, mouse_y.to_f)
  end

  def draw
    # mouse pixel coords. xy: current (if MLB down), zw: click
    if mouse_pressed?
      @last_mouse_position = Vec2D.new(mouse_x.to_f, mouse_y.to_f)
      @mouse_click_state = 1.0
    else
      @mouse_click_state = 0.0
    end
    newton.set('iMouse', last_mouse_position.x, last_mouse_position.y, mouse_click_state, mouse_click_state)
    # Apply the specified shader to any geometry drawn from this point
    shader(newton)
    # Draw the output of the shader onto a rectangle that covers the whole viewport.
    rect(0, 0, width, height)
  end
end

NewtonFractal.new

