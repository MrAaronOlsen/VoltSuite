require 'gosu'
require 'pry-nav'
require 'colorize'

Dir["#{File.dirname(__FILE__)}/lib/core/**/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/gjk/**/*.rb"].each { |f| load(f) }