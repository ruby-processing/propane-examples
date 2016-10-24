#
# Non-orthogonal Reflection 
# by Ira Greenberg. 
# 
# Based on the equation (R = 2N(N*L)-L) where R is the 
# reflection vector, N is the normal, and L is the incident
# vector. NB: variant uses Vec2D in place of PVector
#


attr_reader :base1, :base2, :base_length, :coords, :position, :radius
attr_reader :direction, :speed, :velocity, :incidence 

def setup
  sketch_title 'Reflection One'
  @radius = 6
  @speed = 3.5
  fill(128)
  @base1 = Vec2D.new(0, height - 150)
  @base2 = Vec2D.new(width, height)
  @coords = create_ground
  # start ellipse at middle top of screen
  @position = Vec2D.new(width / 2, 0)  
  # set initial random direction
  @direction = Vec2D.new(rand, rand)
  
end

def draw
  # draw background
  fill(0, 12)
  no_stroke
  rect(0, 0, width, height)
  
  # draw base
  fill(200)
  quad(base1.x, base1.y, base2.x, base2.y, base2.x, height, 0, height)
  
  # calculate base top normal
  base_delta = base2 - base1
  base_delta.normalize!
  normal = Vec2D.new(-base_delta.y, base_delta.x)  
  # draw ellipse
  no_stroke
  fill(255)
  ellipse(position.x, position.y, radius * 2, radius * 2)
  
  # set ellipse velocity vector
  @velocity = Vec2D.new(direction.x, direction.y) 
  @velocity *= speed
  
  # move ellipse according to velocity vector
  @position += velocity
  
  # normalized incidence vector
  @incidence = direction * -1
  
  # detect and handle collision
  coords.each do |coord|
    # check distance between ellipse and base top coordinates
    if position.dist(coord) < radius
      
      # calculate dot product of incident vector and base top normal 
      dot = incidence.dot(normal)
      
      # assign reflection vector to direction vector
      direction.x, direction.y = 2 * normal.x * dot - incidence.x, 2 * normal.y * dot - incidence.y, 0      
      # draw base top normal at collision point
      stroke(255, 128, 0)
      line(position.x, position.y, position.x - normal.x * 100, position.y - normal.y * 100)
     end 
  end
  
  # detect boundary collision
  # right
  if position.x > (width - radius)
    @position.x = width - radius
    @direction.x *= -1
  end
  # left 
  if position.x < radius
    @position.x = radius
    @direction.x *= -1
  end
  # top
  if position.y < radius
    @position.y = radius
    @direction.y *= -1
    # randomize base top
    @base1.y = rand(height - 100..height)
    @base2.y = rand(height - 100..height)
    @coords = create_ground
  end
end

def create_ground
  # calculate length of base top
  @base_length = base1.dist(base2)
  # fill base top coordinate array
  coords = []
  (0 ... base_length.ceil).each do |i|
     coords << Vec2D.new(
     base1.x + ((base2.x - base1.x) / base_length) * i,
     base1.y + ((base2.y - base1.y) / base_length) * i)
  end
  return coords
end

def settings
  size 640, 360, P2D
end
