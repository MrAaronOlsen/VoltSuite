class Mink
  attr_reader :shape, :body, :active, :manifold
  attr_accessor :color, :fill, :z

  def initialize
    @shape1 = @shape2 = nil

    @color_off = Canvas::Colors.white
    @color_on = Canvas::Colors.red

    @fill = false
    @z = 1

    @offset = Trans.new_translate(V.new(200, 200))

    @draw_contact = false
    update
  end

  def update
    return if invalid?
    @draw_contact = false

    @manifold = Manifold.new(@shape1.get_support, @shape2.get_support)
    if @manifold.pre_solve

      if @manifold.solve
        @contact_points = @manifold.contact_points
        @contact_depth = @manifold.contact_depth
        @contact_normal = @manifold.contact_normal

        @draw_contact = true
      end
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

    Gosu.clip_to(50, 50, 750, 750) do
      Canvas::Pencil.poly(world_verts, world_center, @color.get, @fill, @z)
    end

    if @draw_contact
      @contact_points.each do |point|
        Canvas::Pencil.circle(point, 10, @color.get, true, 4)
      end

      normal_start = @offset.transform(V.new(0, 0))
      normal_end = normal_start + @contact_normal * 100
      Canvas::Pencil.segment(normal_start, normal_end, @color.get, 4)
    end
  end

  def set_shapes(shape1, shape2)
    @shape1 = shape1
    @shape2 = shape2

    update
  end
end