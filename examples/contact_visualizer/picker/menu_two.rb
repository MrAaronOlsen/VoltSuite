class MenuTwo
  Active = Struct.new(:shape, :trans, :index)
  attr_reader :active

  def initialize
    @trans = Trans.new_translate(V.new($window_width - 150, 150))
    @selection_box = SelectionBox.new(@trans)

    @spawn_pos = $window_center + V.new(550, 50)

    @line = PickerShapes::Line.new(@trans * Trans.new_translate(V.new(25, 25)), @spawn_pos)
    @tri = PickerShapes::Tri.new(@trans * Trans.new_translate(V.new(25, 125)), @spawn_pos)
    @rect = PickerShapes::Rect.new(@trans * Trans.new_translate(V.new(25, 225)), @spawn_pos)
    @poly = PickerShapes::Poly.new(@trans * Trans.new_translate(V.new(25, 325)), @spawn_pos)
    @circle = PickerShapes::Circle.new(@trans * Trans.new_translate(V.new(50, 450)), @spawn_pos)

    @drawable = [@selection_box, @line, @tri, @rect, @poly, @circle]
    @shapes = [@line, @tri, @rect, @poly, @circle]

    @box = [V.new(0, 0), V.new(100, 0), V.new(100, 100), V.new(0, 100)]
    @box_color = Canvas::Colors.red
    @box_color.fade(-150)

    @active = nil
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
      trans = Trans.new_translate(V.new(0, i * 100)) * @trans
      verts = trans.transform_all(@box)

      support = Support::Poly.new(VectMath.average(verts), verts)

      if gjk.solve(Minkowski.new(mouse_support, support))
        @active = Active.new(shape, trans, 1)
      end
    end
  end

  class SelectionBox
    def initialize(main_trans)
      @trans = main_trans

      @box = [V.new(0, 0), V.new(100, 0), V.new(100, 500), V.new(0, 500)]
      @color = Canvas::Colors.white
      @color.fade(-150)
    end

    def draw
      Canvas::Pencil.rect(@trans.transform_all(@box), @color.get, false, 1)
    end
  end
end