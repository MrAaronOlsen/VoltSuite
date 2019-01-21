module Observer
  class OnButton

    def initialize(key, element)
      @key = key
      @element = element
    end

    def get_key
      @key
    end

    def look(mouse)
      Message::Queue.add_message(Message.new(@element, self, @key))
    end
  end
end