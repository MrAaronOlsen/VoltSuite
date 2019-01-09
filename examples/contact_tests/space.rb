class Space

  def initialize(window)
    @world = Volt::World.new

    @rect = Assets::Shapes::Rect.new(V.new(0, 0), 200, 200)

    tl = V.new(100, 100)
    tr = V.new($window_width - 100, 100)
    br = V.new($window_width - 100, $window_height - 100)
    bl = V.new(100, $window_height - 100)

    @cealing = Assets::Shapes::Wall.new(tl, V.new(0, 0), V.new($window_width - 200, 0))
    @r_wall = Assets::Shapes::Wall.new(tr, V.new(0, 0), V.new(0, $window_height - 200))
    @floor = Assets::Shapes::Wall.new(br, V.new(0, 0), V.new(-($window_width - 200), 0))
    @l_wall = Assets::Shapes::Wall.new(bl, V.new(0, 0), V.new(0, -($window_height - 200)))

    @assets = [@rect, @cealing, @r_wall, @floor, @l_wall]

    @world.add_bodies(@assets.map { |asset| asset.body})

    @dt = 1.0/60.0
  end

  def update
    @world.update(@dt)
  end

  def draw
    @assets.each { |asset| asset.draw }
  end

  def button_down?(key)
  end
end