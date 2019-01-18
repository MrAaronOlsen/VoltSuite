module Controller
  class Controller

    def initialize(mouse)
      @mouse = mouse
      @listeners = Hash.new { |hash, key| hash[key] = Array.new }
    end

    def add_listener(listener)
      @listeners[listener.key].push(listener)
    end

    def query_for_event(key)
      @listeners[key].each do |listener| { listener.send_message(@mouse.pos) } if @events.key?(key)
    end
  end
end