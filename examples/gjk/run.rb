require_relative '../manifest.rb'

require_relative 'updater.rb'
require_relative 'controller.rb'

require_relative 'picker/line.rb'
require_relative 'picker/tri.rb'
require_relative 'picker/rect.rb'
require_relative 'picker/poly.rb'
require_relative 'picker/circle.rb'
require_relative 'picker/menu_one.rb'
require_relative 'picker/menu_two.rb'
require_relative 'picker/picker.rb'

require_relative 'shapes/line.rb'
require_relative 'shapes/tri.rb'
require_relative 'shapes/rect.rb'
require_relative 'shapes/poly.rb'
require_relative 'shapes/circle.rb'

require_relative 'shapes/mink.rb'
require_relative 'shapes/mouse.rb'
require_relative 'shapes/origin.rb'

require_relative 'space.rb'

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