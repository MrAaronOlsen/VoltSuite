class Window < Gosu::Window

	def initialize
    $window_width, $window_height = 1000, 700
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

	def button_down(event)
		close if event == Gosu::KbEscape

		@space.query_events(event)
  end
end