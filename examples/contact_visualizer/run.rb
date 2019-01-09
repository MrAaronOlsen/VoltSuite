def require_all(folder)
	Dir[File.expand_path("#{folder}/*.rb", File.dirname(__FILE__))].each do |file|
		require file
	end
end

require_relative '../manifest.rb'

require_relative 'updater.rb'
require_relative 'controller.rb'

require_all 'picker'
require_all 'shapes'

require_relative 'space.rb'
require_relative 'window.rb'

Window.new.show