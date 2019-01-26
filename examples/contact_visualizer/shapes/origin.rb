class Origin

  def initialize
    @grid_color = Canvas::Colors.white
    @grid_color.fade(-150)

    @area_color = Canvas::Colors.white
    @trans = Trans.new_translate(V.new(50, 50))

    @x = @trans.transform_all([V.new(0, 350), V.new(700, 350)])
    @y = @trans.transform_all([V.new(350, 0), V.new(350, 700)])

    @area = @trans.transform_all([V.new, V.new(700, 0), V.new(700, 700), V.new(0, 700)])

    @origin_trans = Trans.new_translate(V.new(350, 350)) * @trans

    @z = 0
  end

  def get_origin_trans
    @origin_trans
  end

  def get_clip_corners
    [@area[0], @area[2]]
  end

  def draw
    Canvas::Pencil.line(@x, @grid_color.get, @z)
    Canvas::Pencil.line(@y, @grid_color.get, @z)

    Canvas::Pencil.rect(@area, @area_color.get, false, @z)
  end
end