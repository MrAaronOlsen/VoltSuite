module PickerShapes

  class Rect
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @type = "Rectangle"
      @trans = trans
      @spawn_pos = spawn_pos

      @rect = [V.new(0, 0), V.new(50, 0), V.new(50, 50), V.new(0, 50)]
      @color = color
    end

    def draw
      Canvas::Pencil.rect(@trans.transform_all(@rect), @color.get, true, 1)
    end

    def spawn
      GJKShapes::Rect.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end