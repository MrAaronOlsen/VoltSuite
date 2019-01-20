class Space

  def initialize(window)
    @world = World.new
    @controller = Assets::Controller::Controller.new(window)

    @generator = Assets::Shapes::Generator

    @frame = Assets::Frame.new
    @shape_menu = Assets::ShapeMenu::ShapeMenu.new

    @controller.add_listeners(@shape_menu.get_listeners)
    @assets = [@frame, @shape_menu, @controller]
    @world.add_bodies(@frame.bodies)

    @dt = 1.0/60.0
  end

  def update
    @world.update(@dt)
    @controller.update
    @shape_menu.update
  end

  def draw
    @assets.each { |asset| asset.draw }
  end

  def query_listeners(event)
    @controller.query_events(event)
  end
end