class ContactData

  def initialize(offset)
    @offset = offset
    @points_color = Canvas::Colors.red
    @normal_color = Canvas::Colors.blue
    @simplex_color = Canvas::Colors.green
    @draw = false
  end

  def prep(manifold)
    if manifold.solve
      @simplex = @offset.transform_all(manifold.gjk.simplex.get_all)

      @points = manifold.contact_points
      @depth = manifold.contact_depth
      @normal = manifold.contact_normal

      @normal_start = @offset.transform(V.new(0, 0))
      @normal_end = @normal_start - @normal * @depth

      @draw = true
    end
  end

  def clear
    @draw = false
  end

  def draw
    if @draw
      @points.each do |point|
        Canvas::Pencil.circle(point, 10, @points_color.get, true, 5)
      end

      Canvas::Pencil.tri(@simplex, @simplex_color.get, false, 5)
      Canvas::Pencil.segment(@normal_start, @normal_end, @normal_color.get, 5)
    end
  end
end