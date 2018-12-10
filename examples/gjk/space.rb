class Space

  def initialize
    @poly_verts = [V.new(0, 0), V.new(200, 0), V.new(200, 200), V.new(0, 200)]
    @poly_pos = V.new(500, 500)

    live_poly_verts =  @poly_verts.map { |vert| vert + @poly_pos }
    @poly_support = Support::Poly.new(VectMath.average(live_poly_verts), live_poly_verts)

    @poly_fill = false
    @poly_z = 1
    @poly_is_activated = false
    @poly_point_offset

    @circle_support = Support::Circle.new(V.new(700, 500), 100)
    @circle_fill = false
    @circle_z = 1
    @circle_is_activated = false

    @minkowski = Minkowski.new(@poly_support, @circle_support)
    @verts = @minkowski.brute
    @minkowski_hull = Hull.new(@verts)
    @minkowski_fill = false

    @center = VectMath.average(@verts)

    @mouse = [V.new(0, 0), V.new(10, 30), V.new(-10, 30)]
  end

  def draw(window)
    live_poly_verts = @poly_verts.map { |vert| vert + @poly_pos }

    Canvas::Pencil.poly(@minkowski_hull.verts, @center, Canvas::Colors.red.get, @minkowski_fill, 1)

    Canvas::Pencil.poly(live_poly_verts, VectMath.average(live_poly_verts), Canvas::Colors.green.get, @poly_fill, @poly_z)
    Canvas::Pencil.circle(@circle_support.center, @circle_support.radius, Canvas::Colors.blue.get, @circle_fill, @circle_z)

    Canvas::Pencil.tri(get_mouse(window), Canvas::Colors.yellow.get, true, 2)
  end

  def update(window)
    mouse_support = Support::Poly.new(VectMath.average(get_mouse(window)), get_mouse(window))

    gjk = GJK.new

    circle_mink = Minkowski.new(mouse_support, @circle_support)
    poly_mink = Minkowski.new(mouse_support, @poly_support)

    if (gjk.solve(@minkowski))
      @minkowski_fill = true
    else
      @minkowski_fill = false
    end

    if (gjk.solve(circle_mink))
      @circle_fill = true
      @poly_z = 2
    else
      @circle_fill = false
      @poly_z = 1
    end

    if @poly_is_activated
      @poly_pos = get_mouse_pos(window) - @poly_point_offset

      live_poly_verts = @poly_verts.map { |vert| vert + @poly_pos }
      @poly_support = Support::Poly.new(VectMath.average(live_poly_verts), live_poly_verts)

      @minkowski = Minkowski.new(@poly_support, @circle_support)
      @verts = @minkowski.brute
      @minkowski_hull = Hull.new(@verts)
    end

    if (gjk.solve(poly_mink))
      @poly_fill = true
      @poly_z = 2
    else
      @poly_fill = false
      @poly_z = 1
    end
  end

  def button_down?(key, window)
    case key
    when Gosu::MS_LEFT
      if @poly_is_activated
        puts "Polly Is Deactivated"
        @poly_is_activated = false
      else
        if @poly_fill
          puts "Polly Is Activated"
          @poly_is_activated = true
          @poly_point_offset = get_mouse_pos(window) - @poly_pos

          puts @poly_point_offset
        end
      end
    end
  end

  def get_mouse(window)
    pos = get_mouse_pos(window)

    @mouse.map { |point| point + pos }
  end

  def get_mouse_pos(window)
    V.new(window.mouse_x, window.mouse_y)
  end
end