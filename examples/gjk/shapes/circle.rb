class Circle
  attr_reader :shape, :body, :active
  attr_accessor :color, :fill, :z

  def initialize(pos, radius)
    @radius = radius

    @shape = Volt::Shape::Circle.new do |shape|
      shape.set_verts(pos, radius)
    end

    @body = Body.new do |b|
      b.pos = pos
      b.add_shape(@shape)
    end

    @z = 0
    @fill = true
    @color = Canvas::Colors.blue

    @active = false
  end

  def pos
    @body.pos
  end

  def update(mouse)
    @body.pos = mouse.get_mouse_pos - mouse.offset
  end

  def get_support
    Support::Circle.new(pos, @radius)
  end

  def draw
    Canvas::Pencil.circle(pos, @radius, @color.get, @fill, @z)
  end

  def mouse_on
    @fill = true
    @z = 2
  end

  def mouse_off
    @fill = false
    @z = 1
  end

  def active?
    @active
  end

  def activate
    @active = true
  end

  def deactivate
    @active = false
  end
end