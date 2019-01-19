module Message
  class OnHover
    attr_reader :mouse

    def initialize(mouse)
      @mouse = mouse
    end

    def get_key
      "on_hover"
    end
  end
end