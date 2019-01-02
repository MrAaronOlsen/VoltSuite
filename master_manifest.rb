require 'pry-nav'
require 'colorize'

def require_all(folder)
  full_path = File.dirname(caller_locations.last.path) + '/' + folder

	Dir[File.expand_path("#{full_path}/*.rb", File.dirname(__FILE__))].each do |file|
		require file
	end
end

Dir["#{File.dirname(__FILE__)}/lib/core/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/body/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/shapes/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/collision/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/contact/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/joints/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/*.rb"].each { |f| load(f) }