module Listener
  class OnHover
    attr_reader :key

    def initialize(game_object)
      @key = "on_hover"
      @game_object = game_object

      @gjk = GJK.new
    end

    def send_message(mouse)
      if @gjk.solve(Minkowski.new(mouse.get_support, @game_object.get_support))
        @game_object.receive_message(Message::OnHover.new(mouse.get_pos))
      end
    end
  end
end