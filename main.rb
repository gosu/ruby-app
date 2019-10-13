require 'gosu'

class Window < Gosu::Window
  def initialize
    super 800, 600

    self.caption = "Your Ruby/Gosu game goes here"
    @image = Gosu::Image.new("Ruby.png")
  end

  def draw
    angle = Math.sin(Gosu::milliseconds / 500.0) * 5
    @image.draw_rot self.width / 2, self.height / 2, 0, angle
  end

  def update
    # ...
  end

  def needs_cursor?
    true
  end
end

Window.new.show
