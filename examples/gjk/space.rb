class Space < Updater
  attr_reader :shapes, :mouse, :picker

  def initialize(window)
    @controller = Controller.new(self)
    @picker = Picker.new

    @gjk = GJK.new

    shape1 = Poly.new($window_center)
    shape2 = Circle.new($window_center + V.new(300, 300), 100)
    @shapes = [shape1, shape2]

    @mink = Mink.new(shape1, shape2)
    @mouse = Mouse.new(window)

    @drawable = [@mouse, @mink, shape1, shape2, Origin.new, @picker]
  end

  def update
    mouse_support = @mouse.get_support

    update_mink
    update_shapes(mouse_support)
    @picker.update(@gjk, mouse_support)
  end

  def draw
    @drawable.each { |shape| shape.draw }
  end

  def button_down?(key)
    @controller.button_down?(key)
  end
end