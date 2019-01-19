module Messages

  def send_message(message)
    @messages[message.key].push(message)
  end

  def remove_message(key)
    @messages.delete(key)
  end

  def clear_messages
    @messages.clear
  end

  def has_message(key)
    @messages.has_key?(key)
  end

  def has_messages(*keys)
    keys.all? { |key| has_message(key) }
  end

  class Message
    attr_reader :key, :mouse

    def initialize(key: key, mouse: mouse)
      @key = key
      @mouse = mouse
    end
  end
end