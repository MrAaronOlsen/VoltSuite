class Origin

  def initialize(offset, width, height)
    @offset = offset

    @axis_color = Canvas::Colors.black
    @area_color = Canvas::Color.new(80, 220, 220, 220)
    @outline_color = Canvas::Colors.white

    x_center = width / 2
    y_center = height / 2

    @x_axis = @offset.transform_all([V.new(0, y_center), V.new(width, y_center)])
    @y_axis = @offset.transform_all([V.new(x_center, 0), V.new(x_center, height)])

    @area = @offset.transform_all([V.new, V.new(width, 0), V.new(width, height), V.new(0, height)])

    @z = 0
  end

  def center
    VectMath.average(@area)
  end

  def draw
    Canvas::Pencil.line(@x_axis, @axis_color.get, 1)
    Canvas::Pencil.line(@y_axis, @axis_color.get, 1)

    Canvas::Pencil.rect(@area, @area_color.get, true, @z)
    Canvas::Pencil.rect(@area, @outline_color.get, false, 1)
  end
end