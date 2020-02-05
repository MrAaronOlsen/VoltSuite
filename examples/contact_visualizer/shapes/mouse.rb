class Mouse
  attr_reader :shape, :offset
  attr_accessor :color, :fill, :z

  def initialize(window)
    @window = window

    @trans = Transform.new_rotate(-20)
    @shape = get_shape

    @color_fill = Canvas::Colors.black
    @color_ouline = Canvas::Colors.white

    @fill = true
    @z = 999
  end

  def get_support
    mouse = get_mouse

    Contact::Support::Poly.new(VectMath.average(mouse), mouse)
  end

  def get_shape
    @trans.transform_all([V.new(0, 0), V.new(7, 25), V.new(-7, 25)])
  end

  def draw
    Canvas::Pencil.tri(get_mouse, @color_fill.get, true, @z)
    Canvas::Pencil.tri(get_mouse, @color_ouline.get, false, @z)
  end

  def set_offset(pos)
    @offset = get_mouse_pos - pos
  end

  def get_mouse
    pos = get_mouse_pos

    @shape.map { |point| point + pos }
  end

  def get_mouse_pos
    V.new(@window.mouse_x, @window.mouse_y)
  end
end