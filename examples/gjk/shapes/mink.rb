class Mink
  attr_reader :shape, :body, :active, :mink
  attr_accessor :color, :fill, :z

  def initialize(shape1, shape2)
    @shape1 = shape1
    @shape2 = shape2

    @fill = false
    @color = Canvas::Colors.red
    @color.fade(-150)
    @z = 3

    @offset = Trans.new_translate(V.new(200, 200))

    update
  end

  def update
    @mink = Minkowski.new(@shape1.get_support, @shape2.get_support)
    @mink_hull = Hull.new(@mink.brute)
  end

  def world_verts
    @offset.transform_all(@mink_hull.verts)
  end

  def world_center
     @offset.transform(VectMath.average(@mink_hull.verts))
  end

  def draw
    Canvas::Pencil.poly(world_verts, world_center, @color.get, @fill, @z)
  end
end