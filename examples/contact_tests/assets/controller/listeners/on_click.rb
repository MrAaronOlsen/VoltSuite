module Listener
  class OnClick
    attr_reader :key

    def initialize(key, game_object)
      @key = key
      @game_object = game_object
    end

    def send_message(mouse)
      @game_object.receive_message(Message::OnClick.new(key, mouse.get_pos))
    end
  end
end