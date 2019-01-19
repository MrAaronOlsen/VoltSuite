class GameObject
  attr_reader :message_box

  def initialize
    @message_box = Controller::MessageBox.new
  end

  def receive_message(message)
    @message_box.add_message(message)
  end

  def remove_message(key)
    @message_box.remove_message(key)
  end

  def has_messages(*keys)
    @message_box.has_messages(keys)
  end

  def message_count
    @message_box.message_count
  end

  def clear_messages
    @message_box.clear_messages
  end
end