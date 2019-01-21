module Observer
  class OnHover

    def initialize(element)
      @key = "on_hover"
      @element = element

      @gjk = Contact::GJK.new
    end

    def get_key
      @key
    end

    def look(mouse)
      if @gjk.solve(Contact::Minkowski.new(mouse.get_support, @element.get_support))
        Message::Queue.add_message(Message.new(@element, self, @key, mouse))
      end
    end
  end
end