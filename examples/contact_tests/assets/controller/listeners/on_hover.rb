module Listeners
  class OnHover
    attr_reader :key

    def initialize(key, game_object)
      @key = key
      @game_object = game_object

      @gjk = GJK.new
    end

    def send_message(mouse)
      if @gjk.solve(Minkowski.new(mouse.get_support, @game_object.get_support))
        @game_object.send_message(Message::OnHover.new(mouse))
      end
    end
  end
end