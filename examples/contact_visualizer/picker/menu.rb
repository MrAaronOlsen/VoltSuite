class Menu
  attr_reader :index

  def initialize(trans, spawn_pos, index)
    @index = index
    @trans = trans
    @spawn_pos = $window_center + spawn_pos

    @color = Canvas::Colors.grey

    @line = PickerShapes::Line.new(slot(0), @spawn_pos, @color)
    @tri = PickerShapes::Tri.new(slot(1), @spawn_pos, @color)
    @rect = PickerShapes::Rect.new(slot(2), @spawn_pos, @color)
    @poly = PickerShapes::Poly.new(slot(3), @spawn_pos, @color)
    @circle = PickerShapes::Circle.new(slot(4), @spawn_pos, @color)

    @border = Border.new(@trans)

    @drawable = [@border, @line, @tri, @rect, @poly, @circle]
    @shapes = [@line, @tri, @rect, @poly, @circle]

    @active = nil
  end

  def slot(num)
    @trans * Trans.new_translate(V.new(100 / 2 + (100 * num), 50))
  end

  def draw
    @drawable.each { |thing| thing.draw }
  end

  def update(gjk, mouse_support)
    @shapes.find do |shape|
      selection = shape.selection
      gjk.solve(Contact::Minkowski.new(mouse_support, selection.support))
    end
  end

  class Border
    def initialize(trans)
      @trans = trans

      @box = [V.new(0, 0), V.new(500, 0), V.new(500, 100), V.new(0, 100)]
      @color = Canvas::Colors.white
      @color.fade(-150)
    end

    def draw
      Canvas::Pencil.rect(@trans.transform_all(@box), @color.get, false, 1)
    end
  end
end