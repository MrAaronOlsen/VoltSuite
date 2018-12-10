require_relative '../manifest.rb'
require_relative 'space.rb'

$debug = false

class Window < Gosu::Window

	def initialize
    $window_width = 1200
    $window_height = 1200

    super($window_width, $window_height, false)
    self.caption = "GJK Test Bed"

    @space = Space.new
		@time_step = 1.0/60.0
 	end

	def update
    @space.update(self)
  end

	def draw
		@space.draw(self)
	end

	def button_down(button)
		close if button == Gosu::KbEscape

		@space.button_down?(button, self)
  end
end

Window.new.show