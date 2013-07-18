require 'rubygems'
require 'gosu'

class Window < Gosu::Window
  def initialize
    super 800, 600, false

    self.caption = "Your Ruby game/app goes here"
    @image = Gosu::Image.new(self, "Ruby.icns", false)
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
