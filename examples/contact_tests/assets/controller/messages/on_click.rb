module Message
  class OnClick
    attr_reader :key, :mouse

    def initialize(key, mouse)
      @key = key
      @mouse = mouse
    end

    def get_key
      @key
    end
  end
end