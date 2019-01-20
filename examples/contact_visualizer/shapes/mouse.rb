class Mouse
  attr_reader :shape, :offset
  attr_accessor :color, :fill, :z

  def initialize(window)
    @window = window

    @shape = get_shape

    @color = Canvas::Colors.white
    @fill = true
    @z = 999
  end

  def get_support
    mouse = get_mouse

    Contact::Support::Poly.new(VectMath.average(mouse), mouse)
  end

  def get_shape
    [V.new(0, 0), V.new(10, 30), V.new(-10, 30)]
  end

  def draw
    Canvas::Pencil.tri(get_mouse, @color.get, @fill, @z)
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