class ContactData

  def initialize(offset)
    @offset = offset

    @assets = [
      ContactPoints.new(@offset),
      Simplex.new(@offset),
      Polytope.new(@offset),
      ContactNormal.new(@offset)
    ]

    @draw = false
  end

  def prep(manifold)
    if @draw = manifold.solve
      @assets.each { |asset| asset.update(manifold) }
    end
  end

  def clear
    @draw = false
  end

  def draw
    @assets.each { |asset| asset.draw } if @draw
  end

  # Helper Classes
  class ContactPoints
    def initialize(offset)
      @offset = offset
      @points = []
      @color = Canvas::Colors.red
    end

    def update(manifold)
      @points = manifold.contact_points
    end

    def draw
      @points.each { |point| Canvas::Pencil.circle(point, 10, @color.get, true, 9) }
    end
  end

  class ContactNormal
    def initialize(offset)
      @offset = offset
      @start = @offset.transform(V.new)
      @color = Canvas::Colors.red
    end

    def update(manifold)
      @end = @start - manifold.contact_normal * manifold.contact_depth
    end

    def draw
      Canvas::Pencil.segment(@start, @end, @color.get, 7)
    end
  end

  class Simplex
    def initialize(offset)
      @offset = offset
      @simplex = []
      @color = Canvas::Colors.green
    end

    def update(manifold)
      @simplex = @offset.transform_all(manifold.gjk.simplex.get_all)
    end

    def draw
      Canvas::Pencil.tri(@simplex, @color.get, true, 7)
    end
  end

  class Polytope
    def initialize(offset)
      @offset = offset
      @polytope, @center = [], V.new
      @color = Canvas::Colors.yellow
    end

    def update(manifold)
      @polytope = Hull.new(@offset.transform_all(manifold.epa.polytope.get_all)).verts
      @center = VectMath.average(@polytope)
    end

    def draw
      Canvas::Pencil.poly(@polytope, @center, @color.get, true, 6)
    end
  end
end