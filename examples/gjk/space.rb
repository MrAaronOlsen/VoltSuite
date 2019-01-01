class Space < Updater
  attr_reader :shapes, :active_shape, :mouse, :picker

  def initialize(window)
    @controller = Controller.new(self)
    @picker = Picker.new

    @gjk = GJK.new
    @shapes = [nil, nil]

    @mink = Mink.new
    @mouse = Mouse.new(window)

    @drawable = [@mouse, @mink, @picker, Origin.new, ShapeArea.new]
  end

  def update
    mouse_support = @mouse.get_support

    @controller.update
    update_mink
    update_shapes(mouse_support)
    @picker.update(@gjk, mouse_support)
  end

  def draw
    @drawable.each { |shape| shape.draw }

    Gosu.clip_to(800, 150, 850, 1000) do
      @shapes.each { |shape| shape.draw if shape }
    end
  end

  def button_down?(key)
    @controller.button_down?(key)
  end

  def replace_shape(index, shape)
    @shapes[index] = shape
    @mink.set_shapes(@shapes[0], @shapes[1])
  end

  def set_active_shape(active_shape)
    @active_shape = active_shape
  end

  def clear_active_shape
    @active_shape = nil
  end
end