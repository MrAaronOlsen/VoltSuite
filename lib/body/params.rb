module Volt
  class Params
    # position
    attr_reader :pos, :trans
    # linear
    attr_reader :acc, :vel, :mass, :i_mass
    # angular
    attr_reader :angle, :a_vel, :moment, :i_moment
    # forces
    attr_reader :damp, :restitution, :forces, :torque
    # friction
    attr_reader :static_friction, :dynamic_friction
    # collision shapes
    attr_reader :shapes, :cog, :hull, :bounding

    def initialize()
      @pos, @origin_angle, @trans = V.new, 0.0, Trans.new_identity
      @acc, @vel, @mass = V.new, V.new, 0.0
      @angle, @a_vel, @moment = 0.0, 0.0, 0.0
      @damp, @restitution, @forces, @torque = 0.999, 1.0, V.new, 0.0
      @static_friction, @dynamic_friction = 1.0, 1.0
      @shapes, @cog, @bounding = [], V.new, AABB.new(self)
    end

  # Attribute Getters / Setters

    def mass=(mass)
      @mass = mass
      set_i_mass(@mass)
    end

    def moment=(moment)
      @moment = moment
      set_i_moment(@moment)
    end

    def damp=(damp)
      @damp = damp
    end

    def pos=(pos)
      @pos = pos
    end

    def vel=(vel)
      @vel = vel
    end

    def all_verts
      @shapes.reduce(Array.new) do |all, shape|
        all + shape.verts
      end
    end

  # Transform Shape Functions

    def recenter
      hard_transform(Trans.new_translate(@pos - @trans.transform_vert(cog)))
      build
    end

    def offset(vect)
      hard_transform(Trans.new_translate(vect))
      build
    end

    def rotate(angle)
      hard_transform(Trans.new_rotate(angle))
      build
    end

    def scale(x, y)
      hard_transform(Trans.new_scale(x, y))
      build
    end

  # Shapes

    def add_shape(shape)
      shape.body = self
      @shapes << shape
    end

    def add_shapes(shapes)
      shapes.each { |shape| add_shape(shape) }
    end

    def build
      set_transform
      set_cog
      set_hull
    end

    def set_transform
      @trans = Trans.new_transform(@pos, @angle)
    end

    def set_cog
      bot = 0

      @cog = @shapes.reduce(V.new) do |top, shape|
        bot += shape.mass
        top + shape.centroid * shape.mass
      end / bot
    end

    def set_hull
      @hull = Hull.new(all_verts)
    end

  private

    def hard_transform(trans)
      @shapes.each do |shape|
        shape.transform(trans)
      end

      set_cog
    end

    def set_i_mass(mass)
      mass > 0.0 ? @i_mass = 1.0 / mass : @i_mass = 0.0
    end

    def set_i_moment(moment)
      moment > 0.0 ? @i_moment = 1.0 / moment : @i_moment = 0.0
    end
  end
end