class Picker
  attr_reader :active

  def initialize
    @menus = [MenuOne.new, MenuTwo.new]
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