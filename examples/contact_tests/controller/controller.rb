class Controller

  def initialize(window)
    @mouse = Mouse.new(window)
    @listeners = Hash.new { |hash, key| hash[key] = Array.new }
  end

  def add_listeners(listeners_in)
    listeners_in.each { |listener| @listeners[listener.key].push(listener) }
  end

  def query_events(key)
    @listeners[key].each { |listener| listener.send_message(@mouse) if @listeners.has_key?(key) }
  end

  def update
    query_events("on_hover")
    @mouse.update
  end

  def draw
    @mouse.draw
  end
end