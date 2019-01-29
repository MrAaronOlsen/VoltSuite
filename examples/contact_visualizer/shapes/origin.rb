class Origin

  def initialize(offset)
    @offset = offset

    @axis_color = Canvas::Colors.white
    @axis_color.fade(-150)

    @area_color = Canvas::Colors.white
    @area_color.fade(-220)


    @x_axis = @offset.transform_all([V.new(0, 350), V.new(700, 350)])
    @y_axis = @offset.transform_all([V.new(350, 0), V.new(350, 700)])

    @area = @offset.transform_all([V.new, V.new(700, 0), V.new(700, 700), V.new(0, 700)])

    @z = 0
  end

  def center
    VectMath.average(@area)
  end

  def draw
    Canvas::Pencil.line(@x_axis, @axis_color.get, @z)
    Canvas::Pencil.line(@y_axis, @axis_color.get, @z)

    Canvas::Pencil.rect(@area, @area_color.get, true, @z)
  end
end