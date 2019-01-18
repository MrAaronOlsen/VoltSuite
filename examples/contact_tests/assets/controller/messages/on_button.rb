module Message
  class OnButton
    attr_reader :button

    def initialize(button)
      @button = button
    end
  end
end