### PixelFlow examples

Requires peasycam library

Note how we can implement callbacks in jruby with a ruby lambda

__processing__
```java
// callback for rendering the scene
DwSceneDisplay scene_display = new DwSceneDisplay(){
  @Override
  public void display(PGraphics3D canvas) {
    displayScene(canvas);  
  }
};

public void displayScene(PGraphics canvas){
  if(canvas == skylight.renderer.pg_render){
    canvas.background(32);
  }
  canvas.shape(shape);
}
```

__propane__
```ruby
# callback for rendering scene, implements DwSceneDisplay interface
scene_display = lambda do |canvas|
  canvas.background(32) if canvas == skylight.renderer.pg_render
  canvas.shape(shape)
end

# init skylight renderer
@skylight = DwSkyLight.new(context, scene_display, mat_scene_bounds)
```


In [antialiasing.rb][anti] if we just use the overloaded `color` method, jruby complains of overloaded method but guesses right and chooses the correct java signature (float, float, float). Mainly to show how we can do it, we provide an alias method `color_float` that avoids the look up cost in detecting the correct signature, this is not generally important if you can put up with the warning.


The ControlP5 library is overly complicated and does not seem to work well with JRubyArt, the built in `control_panel` is much simpler to use. If you must use ControlP5 see [examples][p5] and the revised [basic_fluid.rb][basic]

NB: where processing sketches use `fill(hexadecimal)` etc in propane we must wrap hexadecimal with color `fill(color(hexadecimal))` (_otherwise fill etc will complain of int too big_)

[anti]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/java/PixelFlow/anti_aliasing.rb
[p5]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/external_library/java/controlP5
[basic]:https://github.com/ruby-processing/propane-examples/blob/master/external_library/java/pixel_flow/fluid_basic.rb
