class Picker
  attr_reader :selection

  def initialize
    menu1_trans = Trans.new_translate(V.new($window_width - 650, 50))
    @menu1 = Menu.new(menu1_trans, V.new(100, 50), 0)

    menu2_trans = Trans.new_transform(V.new($window_width - 50, 150), 90)
    @menu2 = Menu.new(menu2_trans, V.new(600, 50), 1)

    @menus = [@menu1, @menu2]
    @active = nil
  end

  def draw
    @menus.each { |menu| menu.draw }
  end

  def update(gjk, mouse_support)
    @selection = nil

    @menus.each do |menu|
      if menu.update(gjk, mouse_support)
        @selection = menu.selection
      end
    end
  end

  def has_selection?
    !@selection.nil?
  end
end