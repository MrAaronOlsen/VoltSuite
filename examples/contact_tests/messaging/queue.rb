class Message
  class Queue
    @@queue = Array.new

    def self.add_message(message)
      @@queue.push(message)
    end

    def self.dispatch
      @@queue.each do |message|
        to = message.to
        to.add_message(message)
      end

      @@queue.clear
    end
  end
end