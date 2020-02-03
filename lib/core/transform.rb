module Volt
  class Transform
    attr_accessor :a, :c, :tx
    attr_accessor :b, :d, :ty

    def initialize(a = nil, c = nil, tx = nil, b = nil, d = nil, ty = nil)

      if block_given?
        yield self
      else
        @a, @c, @tx = a.to_f, c.to_f, tx.to_f
        @b, @d, @ty = b.to_f, d.to_f, ty.to_f
        @e, @f, @g = 0.0, 0.0, 1.0
      end
    end

  # Handy initializers

    class << self

      def new_identity
        Trans.new(1.0, 0.0, 0.0, 0.0, 1.0, 0.0)
      end

      def new_translate(vect)
        Trans.new(1.0, 0.0, vect.x, 0.0, 1.0, vect.y)
      end

      def new_rotate(angle)
        radian = VoltMath.radian(angle)

        cos = Math.cos(radian)
        sin = Math.sin(radian)

      	Trans.new(cos, -sin, 0.0, sin,  cos, 0.0)
      end

      def new_scale(x, y)
        Trans.new(x.to_f, 0.0, 0.0, 0.0, y.to_f, 0.0)
      end

      def new_transform(vect, angle)
        radian = VoltMath.radian(angle)

        cos = Math.cos(radian)
        sin = Math.sin(radian)

        Trans.new(cos, -sin, vect.x, sin, cos, vect.y)
      end
    end

  # Trans

    def transform(vert)
      x = @a * vert.x + @c * vert.y + @tx
  		y = @b * vert.x + @d * vert.y + @ty

      V.new(x, y)
    end

    alias_method :transform_vert, :transform

    def transform_all(verts)
      verts.map { |vert| transform(vert) }
    end

    alias_method :transform_verts, :transform_all

    def mult(trans)
      self.tap do
        a = @a * trans.a + @c * trans.b
        c = @a * trans.c + @c * trans.d
        tx = @a * trans.tx + @c * trans.ty + @tx
        b = @b * trans.a + @d * trans.b
        d = @b * trans.c + @d * trans.d
        ty = @b * trans.tx + @d * trans.ty + @ty

        @a, @b, @c, @d, @tx, @ty = a, b, c, d, tx, ty
      end
    end

    alias_method :compose!, :mult

    def *(trans)
      Transform.new do |tr|
        tr.a = @a * trans.a + @c * trans.b
        tr.c = @a * trans.c + @c * trans.d
        tr.tx = @a * trans.tx + @c * trans.ty + @tx
        tr.b = @b * trans.a + @d * trans.b
        tr.d = @b * trans.c + @d * trans.d
        tr.ty = @b * trans.tx + @d * trans.ty + @ty
      end
    end

    alias_method :compose, :*

    def inverse
      i = @a * @d - @b * @c

      Trans.new do |tr|
        tr.a = @d / i
        tr.c = @c / -i
        tr.tx = (@d * @tx - @c * @ty) / -i
        tr.b = @b / -i
        tr.d = @a / i
        tr.ty = (@b * @tx - @a * @ty) / i
      end
    end

    def get_rotation
  		Math.atan2(-b, a);
    end

    def get_translation
      V.new(@tx, @ty)
    end

    def to_s
      "A: #{@a} C: #{@c} X: #{@tx}\nB: #{@b} D: #{@d} Y: #{@ty}\n\n"
    end
  end

  Trans = Transform
end