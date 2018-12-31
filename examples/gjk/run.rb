require_relative '../manifest.rb'

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
    $window_width = 1200
    $window_height = 1200

    super($window_width, $window_height, false)
    self.caption = "GJK Test Bed"

    @space = Space.new(self)
		@time_step = 1.0/60.0
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