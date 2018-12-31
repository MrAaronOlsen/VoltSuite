class Origin

  def initialize
    @color = Canvas::Colors.white
    @z = 5
  end

  def draw
    Canvas::Pencil.line([V.new(200, 0), V.new(200, 600)], @color.get, @z)
    Canvas::Pencil.line([V.new(0, 200), V.new(600, 200)], @color.get, @z)
  end
end