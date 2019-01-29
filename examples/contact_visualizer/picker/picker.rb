class Picker
  attr_reader :active

  def initialize
    @menu1 = Menu.new(V.new(100, 50), 0) do |menu|
      menu.trans = Trans.new_translate(V.new($window_width - 650, 50))
      menu.layout = lambda { |num| Trans.new_translate(V.new(100 / 2 + (100 * num), 50)) }
      menu.outline = [V.new(0, 0), V.new(500, 0), V.new(500, 100), V.new(0, 100)]
      menu.direction = lambda { |num| V.new(num * 100, 0) }
    end

    @menu2 = Menu.new(V.new(600, 50), 1) do |menu|
      menu.trans = Trans.new_translate(V.new($window_width - 150, 150))
      menu.layout = lambda { |num| Trans.new_translate(V.new(50, 100 / 2 + (100 * num))) }
      menu.outline = [V.new(0, 0), V.new(100, 0), V.new(100, 500), V.new(0, 500)]
      menu.direction = lambda { |num| V.new(0, num * 100) }
    end

    @menus = [@menu1, @menu2]
    @active = nil
  end

  def draw
    @menus.each { |menu| menu.draw }
  end

  def update(gjk, mouse_support)
    @active = nil

    @menus.each do |menu|
      menu.update(gjk, mouse_support)
      @active = menu.active if menu.active
    end
  end
end