class Menu
  Active = Struct.new(:shape, :trans, :index)
  attr_reader :active, :index
  attr_accessor :trans, :layout, :direction, :outline

  def initialize(spawn_pos, index)
    @index = index
    yield self

    @border = Border.new(@trans, @outline)

    @color = Canvas::Colors.grey
    @spawn_pos = $window_center + spawn_pos

    @line = PickerShapes::Line.new(@trans * @layout.call(0), @spawn_pos, @color)
    @tri = PickerShapes::Tri.new(@trans * @layout.call(1), @spawn_pos, @color)
    @rect = PickerShapes::Rect.new(@trans * @layout.call(2), @spawn_pos, @color)
    @poly = PickerShapes::Poly.new(@trans * @layout.call(3), @spawn_pos, @color)
    @circle = PickerShapes::Circle.new(@trans * @layout.call(4), @spawn_pos, @color)

    @drawable = [@border, @line, @tri, @rect, @poly, @circle]
    @shapes = [@line, @tri, @rect, @poly, @circle]

    @box = [V.new(0, 0), V.new(100, 0), V.new(100, 100), V.new(0, 100)]
    @box_color = Canvas::Colors.red
    @box_color.fade(-150)

    @active = nil
  end

  def slot(num)
    @trans * Trans.new_translate(V.new(75, 100 / 2 + (100 * num)))
  end

  def draw
    @drawable.each { |thing| thing.draw }

    if !@active.nil?
      Canvas::Pencil.rect(@active.trans.transform_all(@box), @box_color.get, false, 3)
    end
  end

  def update(gjk, mouse_support)
    @active = nil

    @shapes.each_with_index do |shape, i|
      trans = Trans.new_translate(@direction.call(i)) * @trans
      verts = trans.transform_all(@box)

      support = Contact::Support::Poly.new(VectMath.average(verts), verts)

      if gjk.solve(Contact::Minkowski.new(mouse_support, support))
        @active = Active.new(shape, trans, @index)
      end
    end
  end

  class Border
    def initialize(main_trans, outline)
      @trans = main_trans

      @box = outline
      @color = Canvas::Colors.white
      @color.fade(-150)
    end

    def draw
      Canvas::Pencil.rect(@trans.transform_all(@box), @color.get, false, 1)
    end
  end
end