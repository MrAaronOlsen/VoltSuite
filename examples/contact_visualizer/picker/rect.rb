module PickerShapes
  class Rect
    attr_reader :selection

    def initialize(trans, spawn_pos, color)
      @spawn_pos = spawn_pos
      @color = color

      @rect = trans.transform_all([V.new(-25, -25), V.new(25, -25), V.new(25, 25), V.new(-25, 25)])

      @selection = Selection.new(trans)
    end

    def draw
      Canvas::Pencil.rect(@rect, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Rect.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end