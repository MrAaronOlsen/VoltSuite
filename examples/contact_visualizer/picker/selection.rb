class Selection
  attr_reader :support

  def initialize(trans)
    @verts = trans.transform_all([V.new(-50, -50), V.new(50, -50), V.new(50, 50), V.new(-50, 50)])
    @support = Contact::Support::Poly.new(VectMath.average(@verts), @verts)

    @color = Canvas::Colors.red
    @color.fade(-150)
  end

  def draw
    Canvas::Pencil.rect(@verts, @color.get, false, 3)
  end
end

class ActiveSelection
  attr_reader :shape, :index, :active

  def set(shape, index)
    @shape = shape
    @index = index

    @active = true
  end

  def clear
    @active = false
  end

  def active?
    @active
  end

  def draw
    @shape.selection.draw if active?
  end
end