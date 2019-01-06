class Window < Gosu::Window
	attr_reader :time_step

	def initialize
    $window_width, $window_height = 1800, 1200
		$window_center = V.new($window_width / 2, $window_height / 2)

    super($window_width, $window_height, false)
    self.caption = "Contact Test Bed"

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