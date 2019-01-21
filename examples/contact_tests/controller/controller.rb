class Controller

  def initialize(window)
    @mouse = Mouse.new(window)
    @observers = Hash.new { |hash, key| hash[key] = Array.new }
  end

  def add_observer(observer)
    @observers[observer.get_key].push(observer)
  end

  def add_observers(observers)
    observers.each { |observer| add_observer(observer) }
  end

  def query_events(key)
    @observers[key].each { |observer| observer.look(@mouse) if @observers.has_key?(key) }
  end

  def update(space)
    @mouse.update
    query_events("on_hover")
  end

  def draw
    @mouse.draw
  end
end