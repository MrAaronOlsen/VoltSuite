class Vector

  attr_reader :x, :y
  attr_reader :name

  def initialize(x = 0.0, y = 0.0)
    @x = x.to_f
    @y = y.to_f
  end

  # Handy constructors
  class << self

    # Makes a unit vector based on the given angle (in degrees)
    def from_angle(degree)
      radian = Convert.radian(degree)
      Vector.new(Math.cos(radian), Math.sin(radian))
    end

    # Makes a vector and rotates it by the given angle (in degrees)
    def with_rotation(x, y, degree)
      Vector.new(x, y).tap { |vect| vect.rotate(degree) }
    end

  end

  # Basic Math Function

  def +(vect)
    Vector.new(@x + vect.x, @y + vect.y)
  end

  def add(vect)
    self.tap { @x += vect.x ; @y += vect.y }
  end

  def -(vect)
    Vector.new(@x - vect.x, @y - vect.y)
  end

  def sub(vect)
    self.tap { @x -= vect.x; @y -= vect.y }
  end

  def *(value)
    Vector.new(@x * value, @y * value)
  end

  def mult(value)
    self.tap { @x *= value; @y *= value }
  end

  def /(value)
    if value.zero?
      self.copy
    else
      Vector.new(@x / value, @y / value)
    end
  end

  def div(value)
    if value.zero?
      self
    else
      self.tap { @x /= value; @y /= value }
    end
  end

  def ==(vect)
    @x == vect.x && @y == vect.y
  end

  # Vector Properties

  def cheap_mag
    @x * @x + @y * @y
  end

  def mag
    Math.sqrt(cheap_mag)
  end

  def dot(vect)
    ( @x * vect.x ) + ( @y * vect.y )
  end

  def cross(vect)
    ( @x * vect.y ) - ( @y * vect.x )
  end

  def cross_z(z)
	   Vector.new(-1.0 * @y * z, @x * z)
  end

  def normal
    Vector.new(-@y, @x)
  end

  def normal_unit
    normal.normalize
  end

  def normalize
    m = mag
    self.tap { @x /= m; @y /= m unless m.zero? }
  end

  def unit
    m = mag
    Vector.new(@x / m, @y / m) unless m.zero?
  end

  # Misc

  def zero!
    self.tap { @x = 0.0; @y = 0.0 }
  end

  def copy
    Vector.new(@x, @y)
  end

  def set(vect)
    @x, @y = vect.x, vect.y
  end

  def flip
    Vect.new(@x * -1, @y * -1)
  end

  def flip!
    self.tap { @x *= -1; @y *= -1 }
  end

  def give_name(name)
    @name = name
  end

  # Rotate self by some degree around origin
  def rotate(degree)
    radian = Convert.radian(degree)

    x = @x
    cos = Math.cos(radian)
    sin = Math.sin(radian)

    self.tap do
      @x = x * cos - @y * sin
      @y = x * sin + @y * cos
    end
	end

  # Overrides

  def to_s
    unless @name.nil?
      "#{@name} | X: #{@x}, Y: #{@y}"
    else
      "X: #{@x}, Y: #{@y}"
    end
  end
end

Vect = Vector
V = Vector