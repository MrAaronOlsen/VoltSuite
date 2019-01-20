module Listener
  class OnHover
    attr_reader :key

    def initialize(game_object)
      @key = "on_hover"
      @game_object = game_object

      @gjk = Contact::GJK.new
    end

    def send_message(mouse)
      if @gjk.solve(Contact::Minkowski.new(mouse.get_support, @game_object.get_support))
        @game_object.send_message(Messages::Message.new(key: @key, mouse: mouse))
      end
    end
  end
end