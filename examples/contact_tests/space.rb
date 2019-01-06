class Space

  def initialize(window)
    @world = Volt::World.new

    @rect = Assets::Shapes::Rect.new(V.new(0, 0), 200, 200)

    @wall = Assets::Shapes::Wall.new(V.new(200, 0), V.new(0, 0), V.new(0, $window_height - 200))
    @floor = Assets::Shapes::Wall.new(V.new(200, $window_height - 200), V.new(0, 0), V.new($window_width, 0))

    @world.add_bodies([@rect.body, @wall.body, @floor.body])

    @dt = 1.0/60.0
  end

  def update
    @rect.update
    @world.update(@dt)
  end

  def draw
    @rect.draw
    @wall.draw
    @floor.draw
  end

  def button_down?(key)
  end
end