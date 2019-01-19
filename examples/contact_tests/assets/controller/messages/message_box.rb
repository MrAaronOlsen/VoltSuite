module Controller
  class MessageBox

    def initialize
      @messages = Hash.new { |hash, key| hash[key] = Array.new }
    end

    def add_message(message)
      @messages[message.get_key].push(message)
    end

    def remove_message(key)
      @messages.delete(key)
    end

    def clear_messages
      @messages.clear
    end

    def has_messages(keys)
      keys.each do |key|
        return false if !@messages.has_key?(key)
      end

      true
    end

    def message_count
      @messages.size
    end

    def print_messages
      @messages.each { |k, v| puts k }
    end
  end
end