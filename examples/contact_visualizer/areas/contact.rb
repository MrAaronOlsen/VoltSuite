module Areas
  class Contact
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(offset)
      @clip_area = ClipArea.new(offset.transform(V.new), 700, 700)

      @origin = Origin.new(offset)
      @shape1 = @shape2 = nil

      @color_off = Canvas::Colors.white
      @color_on = Canvas::Colors.white

      @fill = false
      @z = 1

      @offset = Trans.new_translate(@origin.center)
      @contact_data = ContactData.new(@offset)

      update
    end

    def update
      return if invalid?
      @manifold = Volt::Contact::Manifold.new(@shape1.get_support, @shape2.get_support)

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
      @origin.draw
      return if invalid?

      @clip_area.draw do
        Canvas::Pencil.poly(world_verts, world_center, @color.get, true, 3)
        @contact_data.draw
      end
    end

    def set_shapes(shape1, shape2)
      @shape1 = shape1
      @shape2 = shape2

      update
    end
  end
end