class Space
  attr_reader :shapes, :active_shape, :mouse, :picker

  def initialize(window)
    @controller = Controller.new(self)

    @gjk = Contact::GJK.new
    @shapes = [nil, nil]

    @mouse = Mouse.new(window)

    @shape_area = Areas::Shape.new(Trans.new_translate(V.new(475, 125)))
    @clip_area = ClipArea.new(@shape_area.origin, @shape_area.width, @shape_area.height)

    @picker = Picker.new(@shape_area)

    @contact_area = Areas::Contact.new(Trans.new_translate(V.new(50, 200)))

    @background = GJKShapes::Background.new(V.new, $window_width, $window_height, Canvas::Color.new(80, 220, 220, 220))

    @drawable = [
      @mouse,
      @picker,
      @shape_area,
      @contact_area,
      @background
    ]
  end

  def update
    mouse_support = @mouse.get_support

    @controller.update
    update_contact_area
    update_shapes(mouse_support)
    @picker.update(@gjk, mouse_support)
  end

  def draw
    @drawable.each { |shape| shape.draw }

    @clip_area.draw do
      @shapes.each { |shape| shape.draw if shape }
    end
  end

  def button_down?(key)
    @controller.button_down?(key)
  end

  def replace_shape(index, shape)
    @shapes[index] = shape
    @contact_area.set_shapes(@shapes[0], @shapes[1])
  end

  def set_active_shape(active_shape)
    @active_shape = active_shape
  end

  def clear_active_shape
    @active_shape = nil
  end

  def update_contact_area
    return if @contact_area.invalid?
    @contact_area.contact? ? @contact_area.active : @contact_area.inactive
  end

  def update_shapes(mouse_support)
    @shapes.each do |shape|
      next if shape.nil?

      mouse_mink = Contact::Minkowski.new(mouse_support, shape.get_support)
      @gjk.solve(mouse_mink) ? shape.mouse_on : shape.mouse_off

      if shape.active?
        shape.update(@mouse)
        @contact_area.update
      end
    end
  end
end