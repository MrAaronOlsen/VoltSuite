require_relative '../manifest.rb'

require_relative 'updater.rb'
require_relative 'picker.rb'

require_relative 'space.rb'
require_relative 'controller.rb'

require_relative 'shapes/poly.rb'
require_relative 'shapes/circle.rb'
require_relative 'shapes/mink.rb'
require_relative 'shapes/mouse.rb'
require_relative 'shapes/origin.rb'

$debug = false

class Window < Gosu::Window
	attr_reader :time_step

	def initialize
    $window_width, $window_height = 1800, 1200
		$window_center = V.new($window_width / 2, $window_height / 2)

    super($window_width, $window_height, false)
    self.caption = "GJK Test Bed"

    @space = Space.new(self)
 	end

	def update
    @space.update
  end

	def draw
		@space.draw
	end

	def button_down(button)
		close if button == Gosu::KbEscape

		@space.button_down?(button)
  end
end

Window.new.show