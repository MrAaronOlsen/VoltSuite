module Listeners
  class OnButton
    attr_reader :key

    def initialize(key, game_object)
      @key = key
      @game_object = game_object
    end

    def send_message(mouse)
      @game_object.send_message(Message::OnButton.new)
    end
  end
end