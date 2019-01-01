class Mink
  attr_reader :shape, :body, :active, :mink
  attr_accessor :color, :fill, :z

  def initialize(shape1, shape2)
    @shape1 = shape1
    @shape2 = shape2

    @color_off = Canvas::Colors.white
    @color_on = Canvas::Colors.red

    @fill = false
    @z = 1

    @offset = Trans.new_translate(V.new(200, 200))

    update
  end

  def update
    @mink = Minkowski.new(@shape1.get_support, @shape2.get_support)
    @mink_hull = Hull.new(@mink.brute)
  end

  def active
    @color = @color_on
  end

  def inactive
    @color = @color_off
  end

  def world_verts
    @offset.transform_all(@mink_hull.verts)
  end

  def world_center
     @offset.transform(VectMath.average(@mink_hull.verts))
  end

  def draw
    Gosu.clip_to(0, 0, 800, 800) do
      Canvas::Pencil.poly(world_verts, world_center, @color.get, @fill, @z)
    end
  end

  def set_shapes(shape1, shape2)
    @shape1 = shape1
    @shape2 = shape2

    update
  end
end