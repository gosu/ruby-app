require 'gosu'

class Window < Gosu::Window
  def initialize
    super 800, 600

    self.caption = "Your Ruby/Gosu game goes here"
    @image = Gosu::Image.new("Ruby.icns")
  end

  def draw
    @image.draw_rot self.width / 2, self.height / 2, 0, Math.sin(Gosu::milliseconds / 500.0) * 5
  end

  def update
    # ...
  end

  def needs_cursor?
    true
  end
end

Window.new.show
