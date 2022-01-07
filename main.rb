require "gosu"

# Some available libraries...
require "chipmunk"
require "opengl"

class Window < Gosu::Window
  def initialize
    super 800, 600

    self.caption = "Your Ruby/Gosu game goes here"
    @image = Gosu::Image.new("Ruby.png")
  end

  def draw
    angle = Math.sin(Gosu::milliseconds / 500.0) * 5
    @image.draw_rot self.width / 2, self.height / 2, 0, angle, 0.5, 0.5, 0.5, 0.5
  end

  def update
    # ...
  end
end

Window.new.show
