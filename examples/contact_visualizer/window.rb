class Window < Gosu::Window
	attr_reader :time_step

	def initialize
    $window_width, $window_height = 1000, 700
		$window_center = V.new($window_width / 2, $window_height / 2)

    super($window_width, $window_height, false)
    self.caption = "GJK Test Bed"

    @space = Space.new(self)
 	end

	def update
    @space.update
  end

	def draw
		StackProf.run(mode: :wall, out: 'stackprof.dump') do
			@space.draw
		end
	end

	def button_down(button)
		close if button == Gosu::KbEscape

		@space.button_down?(button)
  end
end