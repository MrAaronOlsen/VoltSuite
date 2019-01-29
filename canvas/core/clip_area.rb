class ClipArea

  def initialize(origin, width, height)
    @origin = origin
    @width = width
    @height = height
  end

  def draw
    Gosu.clip_to(@origin.x, @origin.y, @width, @height) do
      yield
    end
  end
end