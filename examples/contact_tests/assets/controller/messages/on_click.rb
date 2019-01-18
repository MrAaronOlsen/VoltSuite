module Message
  class OnClick
    attr_reader :mouse

    def initialize(mouse)
      @mouse = mouse
    end
  end
end