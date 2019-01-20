require 'simplecov'
SimpleCov.start do
  add_filter('/spec/')
  add_filter('/manifest.rb')
end

require 'rspec'
require 'pry'

Dir["./spec/custom_matchers/*.rb"].each { |file| require file }
require './lib/volt-collision.rb'

RSpec::configure do |config|
  config.include(BeWithinVect)
end