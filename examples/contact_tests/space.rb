class Space

  def initialize(window)
    @world = Volt::World.new
    @generator = Assets::Shapes::Generator

    @shape1 = @generator.new_rectangle(V.new(300, $window_height) / 2)
    @shape1.body.vel = V.new(400, 0)

    @shape2 = @generator.new_circle(V.new($window_width - 300, $window_height / 2))
    @shape2.body.vel = V.new(-400, 0)

    @frame = Assets::Frame.new
    @assets = [@shape1, @shape2, @frame]

    @world.add_body(@shape1.body)
    @world.add_body(@shape2.body)
    @world.add_bodies(@frame.bodies)

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