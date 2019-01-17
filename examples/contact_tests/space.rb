class Space

  def initialize(window)
    @world = Volt::World.new
    @generator = Assets::Shapes::Generator

    @frame = Assets::Frame.new
    @shape_menu_l = Assets::ShapeMenu::ShapeMenu.new(Transform.new_translate(V.new(200, $window_height / 2)))
    @shape_menu_r = Assets::ShapeMenu::ShapeMenu.new(Transform.new_translate(V.new($window_width - 200, $window_height / 2)))

    @assets = [@frame, @shape_menu_l, @shape_menu_r]

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