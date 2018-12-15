module Volt
  class Shape
    attr_reader :name, :support
    attr_reader :centroid, :verts, :radius
    attr_reader :type, :static, :mass, :body

    def initialize(type)
      @type = type
      @static = false
      @mass, @centroid, @verts = 0, Vect.new, []
    end

    def name=(name)
      @name = name
    end

    def body=(body)
      @body = body
      body.add_shape(self)
    end

    def mass=(mass)
      @mass = mass
    end

    def static=(static)
      @static = static
    end

    def transform(trans)
      @verts = trans.transform_all(@verts)
      @centroid = VectMath.average(@verts)
    end
  end
end