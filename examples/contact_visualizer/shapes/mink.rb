class Mink
  attr_reader :shape, :body, :active
  attr_accessor :color, :fill, :z

  def initialize(origin)
    @offset = origin.get_origin_trans
    @clip = origin.get_clip_corners

    @shape1 = @shape2 = nil

    @color_off = Canvas::Colors.white
    @color_on = Canvas::Colors.red

    @fill = false
    @z = 1

    @contact_data = ContactData.new(@offset)

    update
  end

  def update
    return if invalid?
    @manifold = Contact::Manifold.new(@shape1.get_support, @shape2.get_support)

    if @manifold.pre_solve
      @contact_data.prep(@manifold)
    else
      @contact_data.clear
    end

    @mink_hull = Hull.new(@manifold.minkowski.brute)
  end

  def contact?
    @manifold.contact?
  end

  def invalid?
    @shape1.nil? || @shape2.nil?
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
    return if invalid?

    Gosu.clip_to(50, 50, 700, 700) do
      Canvas::Pencil.poly(world_verts, world_center, @color.get, @fill, @z)

      @contact_data.draw
    end


  end

  def set_shapes(shape1, shape2)
    @shape1 = shape1
    @shape2 = shape2

    update
  end
end