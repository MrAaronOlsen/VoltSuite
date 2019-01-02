require_relative '../manifest.rb'

require_relative 'updater.rb'
require_relative 'controller.rb'

require_all 'picker'
require_all 'shapes'

require_relative 'space.rb'
require_relative 'window.rb'

Window.new.show