class Origin

  def initialize
    @grid_color = Canvas::Colors.white
    @grid_color.fade(-150)

    @area_color = Canvas::Colors.white

    @x = [V.new(50, 200), V.new(800, 200)]
    @y = [V.new(200, 50), V.new(200, 800)]

    @area = [V.new(50, 50), V.new(800, 50), V.new(800, 800), V.new(50, 800)]

    @z = 0
  end

  def draw
    Canvas::Pencil.line(@x, @grid_color.get, @z)
    Canvas::Pencil.line(@y, @grid_color.get, @z)

    Canvas::Pencil.rect(@area, @area_color.get, false, @z)
  end
end