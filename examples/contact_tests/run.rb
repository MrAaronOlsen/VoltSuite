def require_all(folder)
	Dir[File.expand_path("#{folder}/*.rb", File.dirname(__FILE__))].each do |file|
		require file
	end
end

require_relative '../manifest.rb'

require_all 'assets/shapes'

require_relative 'space.rb'
require_relative 'window.rb'

Window.new.show