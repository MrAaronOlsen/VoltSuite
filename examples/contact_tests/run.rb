def require_all(folder)
	Dir[File.expand_path("#{folder}/*.rb", File.dirname(__FILE__))].each do |file|
		require file
	end
end

require_relative '../manifest.rb'

require_all 'assets/controller/messages'
require_all 'assets/controller/listeners'
require_all 'assets/controller'

require_all 'objects'

require_all 'assets/shapes'

require_all 'assets/shape_menu/menu_shapes'
require_all 'assets/shape_menu'

require_all 'assets'

require_relative 'space.rb'
require_relative 'window.rb'

Window.new.show