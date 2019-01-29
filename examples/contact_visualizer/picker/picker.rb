class Picker
  attr_reader :selection

  def initialize
    menu1_trans = Trans.new_translate(V.new($window_width - 650, 50))
    @menu1 = Menu.new(menu1_trans, V.new(100, 50), 0)

    menu2_trans = Trans.new_transform(V.new($window_width - 50, 150), 90)
    @menu2 = Menu.new(menu2_trans, V.new(600, 50), 1)

    @menus = [@menu1, @menu2]
    @selection = ActiveSelection.new
  end

  def draw
    @selection.draw
    @menus.each { |menu| menu.draw }
  end

  def update(gjk, mouse_support)
    @selection.clear

    @menus.each do |menu|
      shape = menu.update(gjk, mouse_support)

      if !shape.nil?
        @selection.set(shape, menu.index)
        break
      end
    end
  end

  def has_selection?
    @selection.active?
  end
end