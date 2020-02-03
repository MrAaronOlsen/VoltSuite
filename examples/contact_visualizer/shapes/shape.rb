module GJKShapes
  class Shape
    attr_reader :on_hover

    def initialize
      @color = Canvas::Colors.white
      @color_on = Canvas::Colors.yellow
      @color_off = Canvas::Colors.white

      @on_hover = false
      @z = 1
    end

    def mouse_on
      @color = @color_on
      @on_hover = true
      @z = 2
    end

    def mouse_off
      @color = @color_off
      @on_hover = false
      @z = 1
    end

  end
end