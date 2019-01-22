def require_all(folder)
	Dir[File.expand_path("#{folder}/*.rb", File.dirname(__FILE__))].each do |file|
		require file
	end
end

require_relative '../manifest.rb'

require_relative 'messaging/message.rb'
require_relative 'messaging/queue.rb'

require_relative 'elements/messaging.rb'
require_relative 'elements/element.rb'

require_relative 'assets/arena.rb'

require_relative 'assets/shapes/circle.rb'
require_relative 'assets/shapes/segment.rb'
require_relative 'assets/shapes/triangle.rb'
require_relative 'assets/shapes/rectangle.rb'
require_relative 'assets/shapes/polygon.rb'

require_relative 'assets/shapes/generator.rb'

require_relative 'controller/controller.rb'
require_relative 'controller/mouse.rb'
require_relative 'controller/observers/on_button.rb'
require_relative 'controller/observers/on_click.rb'
require_relative 'controller/observers/on_hover.rb'

require_relative 'menus/shape/menu.rb'
require_relative 'menus/shape/components/border.rb'
require_relative 'menus/shape/components/circle.rb'
require_relative 'menus/shape/components/segment.rb'
require_relative 'menus/shape/components/triangle.rb'
require_relative 'menus/shape/components/rectangle.rb'
require_relative 'menus/shape/components/polygon.rb'

require_relative 'space.rb'
require_relative 'window.rb'

Window.new.show