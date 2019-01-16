class ContactData

  def initialize(offset)
    @offset = offset
    @color = Canvas::Colors.yellow
    @draw = false
  end

  def prep(manifold)
    if manifold.solve
      @points = manifold.contact_points
      @depth = manifold.contact_depth
      @normal = manifold.contact_normal

      @normal_start = @offset.transform(V.new(0, 0))
      @normal_end = @normal_start + @normal * @depth

      @draw = true
    end
  end

  def draw
    if @draw
      @points.each do |point|
        Canvas::Pencil.circle(point, 10, @color.get, true, 5)
      end

      Canvas::Pencil.segment(@normal_start, @normal_end, @color.get, 5)
    end

    @draw = false
  end
end