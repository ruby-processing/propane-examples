### Dealing with processing coordinate system ###

For library see `library/circles/circles.rb`

If you want to create Math Sketches in processing, you need to deal with peculiar coordinate systems, where the Y-axis is inverted in theory you should be able to do.

```ruby
scale(1, -1)
translate(0, -height)
```
But that will mess up any text (plus you probably need to `push_matrix` and `pop_matrix`) so it is probably simpler to create a parallel coordinate system for the math, and translate that back to the screen (using the processing `map` function or in `propane` and `JRubyArt` use `map1d`).

We have done this in `circumcircle_sketch.rb` or just accept the processing coordinate system as we have with `basic_cirmcumcircle_sketch.rb` (it is much simpler).

### PVector limitations ###

PVector is a 3D vector, that is often used as a 2D vector, to my mind that is just plain wrong. If you evaluate the cross product of a 2D vector you get a float (you may see somewhere that a cross product does not exist for 2D vectors, but it can be useful).  The cross product of PVector yields another PVector, so cannot be used in the calculation of the area of the triangle as defined by two vectors _cf_ Vec2D:-

```ruby
a = Vec2D.new(100, 0)
b = Vec2D.new(0, 100)

a.cross(b).abs == 10_000 # or twice the area of the triangle enclosed by a, b

```
Further we can use the cross product in a test for collinearity

```ruby

# given 3 points in 2D space
a = Vec2D.new(0, 0)
b = Vec2D.new(100, 100)
c = Vec2D.new(200, 200)

(a - b).cross(b - c) == 0 # the area of the triangle is zero, so a, b, c are collinear

```

Also because we were able to separate the logic, we were able to confidently re-factor the Barbara Almeida sketch to use Matrix math to determine the circumcenter

### Matrix Math ###

For detailed workings see [Circumcircle at Mathworld Wolfram.com][circumcircle]


a = {{x<sub>1</sub> y<sub>1</sub> 1}, {x<sub>2</sub> y<sub>2</sub> 1}, {x<sub>3</sub> y<sub>3</sub> 1}}

bx = -{{x<sub>1</sub><sup>2</sup> + y<sub>1</sub><sup>2</sup> y<sub>1</sub> 1}, {x<sub>2</sub><sup>2</sup> + y<sub>2</sub><sup>2</sup> y<sub>2</sub> 1}, {x<sub>3</sub><sup>2</sup> + y<sub>3</sub><sup>2</sup> y<sub>3</sub> 1}}

by = {{x<sub>1</sub><sup>2</sup> + y<sub>1</sub><sup>2</sup> x<sub>1</sub> 1}, {x<sub>2</sub><sup>2</sup> + y<sub>2</sub><sup>2</sup> x<sub>2</sub> 1}, {x<sub>3</sub><sup>2</sup> + y<sub>3</sub><sup>2</sup> x<sub>3</sub> 1}}

xo = -bx / 2 * a

yo = -by / 2 * a


[circumcircle]:http://mathworld.wolfram.com/Circumcircle.html



