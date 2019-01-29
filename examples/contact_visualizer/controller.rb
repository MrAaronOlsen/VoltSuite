class Controller

  def initialize(space)
    @space = space
  end

  def button_down?(key)
    case key
    when Gosu::MS_LEFT
      check_active_shapes
      check_picker
    end
  end

  def update
    rotate_active_shape(1) if Gosu.button_down?(Gosu::KbRight)
    rotate_active_shape(-1) if Gosu.button_down?(Gosu::KbLeft)
  end

  def check_active_shapes
    active_shapes = VectMath::Heap.new(lambda { |x, y| x.z <= y.z } )
    @space.clear_active_shape

    @space.shapes.each do |shape|
      next if shape.nil?

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

      @space.set_active_shape(active_shape)
      @space.mouse.set_offset(active_shape.pos)
    end
  end

  def rotate_active_shape(angle)
    @space.active_shape.rotate(angle) if @space.active_shape
  end

  def check_picker
    if @space.picker.has_selection?
      selection = @space.picker.selection
      @space.replace_shape(selection.index, selection.shape.spawn)
    end
  end
end