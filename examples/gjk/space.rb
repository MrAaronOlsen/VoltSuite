class Space
  attr_reader :shapes, :mouse

  def initialize(window)
    @controller = Controller.new(self)
    @gjk = GJK.new

    shape1 = Poly.new(V.new(600, 590))
    shape2 = Circle.new(V.new(700, 500), 100)

    @shapes = [shape1, shape2]
    @mink = Mink.new(shape1, shape2)

    @mouse = Mouse.new(window)

    @drawable = [@mouse, @mink, shape1, shape2, Origin.new]
  end

  def update
    mouse_support = @mouse.get_support
    @gjk.solve(@mink.mink) ? @mink.fill = true : @mink.fill = false

    @shapes.each do |shape|
      mouse_mink = Minkowski.new(mouse_support, shape.get_support)
      @gjk.solve(mouse_mink) ? shape.mouse_on : shape.mouse_off

      if shape.active?
        shape.update(@mouse)
        @mink.update
      end
    end
  end

  def draw
    @drawable.each { |shape| shape.draw }
  end

  def button_down?(key)
    @controller.button_down?(key)
  end
end