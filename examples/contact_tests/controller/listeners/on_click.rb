module Listener
  class OnClick
    attr_reader :key

    def initialize(key, game_object)
      @key = key
      @game_object = game_object
    end

    def send_message(mouse)
      @game_object.send_message(Messaging::Message.new(key: @key, mouse: mouse))
    end
  end
end