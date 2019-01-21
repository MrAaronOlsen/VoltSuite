module Messaging

  def add_message(message)
    @messages[message.key] = message
  end

  def remove_message(key)
    @messages.delete(key)
  end

  def get_message(key)
    @messages[key]
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
end