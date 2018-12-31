class Picker
  Active = Struct.new(:shape, :trans)

  attr_reader :active

  def initialize
    @trans = Trans.new_translate(V.new($window_width - 650, 50))
    @selection_box = SelectionBox.new(@trans)

    @line = PickerShapes::Line.new(@trans)
    @tri = PickerShapes::Tri.new(@trans)
    @rect = PickerShapes::Rect.new(@trans)
    @poly = PickerShapes::Poly.new(@trans)
    @circle = PickerShapes::Circle.new(@trans)

    @drawable = [@selection_box, @line, @tri, @rect, @poly, @circle]
    @shapes = [@line, @tri, @rect, @poly, @circle]

    @box = [V.new(0, 0), V.new(100, 0), V.new(100, 100), V.new(0, 100)]
    @box_color = Canvas::Colors.red
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
      trans = Trans.new_translate(V.new(i * 100, 0)) * @trans
      verts = trans.transform_all(@box)

      support = Support::Poly.new(VectMath.average(verts), verts)
      @active = Active.new(shape, trans) if gjk.solve(Minkowski.new(mouse_support, support))
    end
  end
end

class SelectionBox
  def initialize(main_trans)
    @trans = main_trans

    @box = [V.new(0, 0), V.new(500, 0), V.new(500, 100), V.new(0, 100)]
    @color = Canvas::Colors.white
  end

  def draw
    Canvas::Pencil.rect(@trans.transform_all(@box), @color.get, false, 1)
  end
end

module PickerShapes
  class Line
    attr_reader :type

    def initialize(main_trans)
      @type = "Line"

      @local_trans = Trans.new_translate(V.new(25, 25))
      @trans = @local_trans * main_trans

      @line = @trans.transform_all([V.new(0, 0), V.new(50, 50)])
      @color = Canvas::Colors.yellow
    end

    def draw
      Canvas::Pencil.line(@line, @color.get, 1)
    end

    def check(mouse_mink)
      @boundary = @trans.transform_all([V.new(0, 0), V.new(100, 0), V.new(100, 100), V.new(0, 100)])
    end
  end

  class Tri
    attr_reader :type

    def initialize(main_trans)
      @type = "Triangle"

      @local_trans = Trans.new_translate(V.new(125, 25))
      @trans = @local_trans * main_trans

      @tri = [V.new(25, 0), V.new(50, 50), V.new(0, 50)]
      @color = Canvas::Colors.green
    end

    def draw
      Canvas::Pencil.tri(@trans.transform_all(@tri), @color.get, true, 1)
    end
  end

  class Rect
    attr_reader :type

    def initialize(main_trans)
      @type = "Rectangle"

      @local_trans = Trans.new_translate(V.new(225, 25))
      @trans = @local_trans * main_trans

      @rect = [V.new(0, 0), V.new(50, 0), V.new(50, 50), V.new(0, 50)]
      @color = Canvas::Colors.blue
    end

    def draw
      Canvas::Pencil.rect(@trans.transform_all(@rect), @color.get, true, 1)
    end
  end

  class Poly
    attr_reader :type

    def initialize(main_trans)
      @type = "Polygon"

      @local_trans = Trans.new_translate(V.new(325, 25))
      @trans = @local_trans * main_trans

      @poly = [V.new(5, 0), V.new(30, 10), V.new(45, 30), V.new(50, 50), V.new(10, 40), V.new(0, 30)]
      @color = Canvas::Colors.purple
    end

    def draw
      verts = @trans.transform_all(@poly)

      Canvas::Pencil.poly(verts, VectMath.average(verts), @color.get, true, 1)
    end
  end

  class Circle
    attr_reader :type

    def initialize(main_trans)
      @type = "Circle"

      @local_trans = Trans.new_translate(V.new(450, 50))
      @trans = @local_trans * main_trans

      @center = V.new(0, 0)
      @radius = 25

      @color = Canvas::Colors.orange
    end

    def draw
      Canvas::Pencil.circle(@trans.transform(@center), @radius, @color.get, true, 1)
    end
  end
end