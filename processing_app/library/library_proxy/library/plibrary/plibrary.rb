# This class demonstrates how by inheriting from the abstract class LibraryProxy
# we can access 'pre', 'draw' and 'post' (Note we need a draw method even
# though it can be empty)
class MyLibrary < LibraryProxy
  attr_reader :app

  def initialize(parent)
    @app = parent
  end

  def pre
    background(100) # just for demo
  end

  def draw
    app.fill(200, 100)
    app.ellipse(150, 100, 200, 60)
  end
end
