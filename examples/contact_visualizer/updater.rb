class Updater

  def update_mink
    return if @mink.invalid?

    @mink.contact? ? @mink.active : @mink.inactive
  end

  def update_shapes(mouse_support)
    @shapes.each do |shape|
      next if shape.nil?

      mouse_mink = Minkowski.new(mouse_support, shape.get_support)
      @gjk.solve(mouse_mink) ? shape.mouse_on : shape.mouse_off

      if shape.active?
        shape.update(@mouse)
        @mink.update
      end
    end
  end
end