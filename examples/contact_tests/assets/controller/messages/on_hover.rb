module Message
  class OnHover
    attr_reader :mouse

    def initialize(mouse)
      @mouse = mouse
    end
  end
end