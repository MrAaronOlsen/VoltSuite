require 'pry-nav'
require 'colorize'

Dir["#{File.dirname(__FILE__)}/lib/core/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/body/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/collision/**/*.rb"].each { |f| load(f) }