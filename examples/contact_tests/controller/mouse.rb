class Mouse

  def initialize(window)
    @window = window
    @shape = get_shape

    @trans = Trans.new_translate(get_pos)

    @color = Canvas::Colors.grey
    @fill = true
    @z = 999
  end

  def get_pos
    V.new(@window.mouse_x, @window.mouse_y)
  end

  def update
    @trans = Trans.new_translate(get_pos)
  end

  def draw
    Canvas::Pencil.tri(@trans.transform_all(@shape), @color.get, @fill, @z)
  end

  def get_support
    Contact::Support::Poly.new(VectMath.average(@trans.transform_all(@shape)), @trans.transform_all(@shape))
  end

private

  def get_shape
    [V.new(0, 0), V.new(10, 20), V.new(-10, 20)]
  end
end