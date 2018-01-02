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
