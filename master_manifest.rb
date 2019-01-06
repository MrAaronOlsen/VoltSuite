require 'pry-nav'
require 'colorize'

Dir["#{File.dirname(__FILE__)}/lib/core/**/*.rb"].each { |f| load(f) }

require './lib/body/params.rb'
require './lib/body/body.rb'
require './lib/body/aabb.rb'
require './lib/body/hull.rb'

Dir["#{File.dirname(__FILE__)}/lib/shapes/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/collision/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/contact/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/joints/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/*.rb"].each { |f| load(f) }