class Space

  def initialize(window)
    @world = Volt::World.new
    @generator = Assets::Shapes::Generator

    @frame = Assets::Frame.new

    # @shape_menu = Assets::ShapeMenu::ShapeMenu.new()

    @assets = [@frame]

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