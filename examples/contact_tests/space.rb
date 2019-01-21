class Space

  def initialize(window)
    @world = World.new

    @shape_gen = Assets::Shapes::Generator
    @shape_menu = Menus::Shape::Menu.new(V.new(100, 100))
    @arena = Assets::Arena.new(V.new(300, 100))

    @controller = Controller.new(window)
    @controller.add_observers(@shape_menu.get_observers)

    @assets = [@arena, @shape_menu, @controller]
    # @world.add_bodies(@arena.bodies)
    @dt = 1.0/60.0
  end

  def update
    # @world.update(@dt)
    @controller.update
    @shape_menu.update
    
    Message::Queue.dispatch
  end

  def draw
    @assets.each { |asset| asset.draw }
  end

  def query_events(event)
    @controller.query_events(event)
  end
end