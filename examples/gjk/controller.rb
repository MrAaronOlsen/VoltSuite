class Controller

  def initialize(space)
    @space = space
  end

  def button_down?(key)
    case key
    when Gosu::MS_LEFT
      check_active_shapes
    end
  end

  def check_active_shapes
    active_shapes = Heap.new(lambda { |x, y| x.z <= y.z } )

    @space.shapes.each do |shape|
      if shape.active?
        shape.deactivate
      else
        if shape.fill
          active_shapes.add(shape)
        end
      end
    end

    active_shape = active_shapes.pop

    if active_shape != nil
      active_shape.activate
      @space.mouse.set_offset(active_shape.pos)
    end
  end
end