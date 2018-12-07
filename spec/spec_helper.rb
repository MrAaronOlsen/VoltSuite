require 'simplecov'
SimpleCov.start do
  add_filter('/spec/')
  add_filter('/manifest.rb')
end

require 'rspec'
require 'pry'

require './master_manifest.rb'

Dir["./spec_helpers/*.rb"].each { |file| require file }

RSpec::configure do |config|
  config.include(BeWithinVect)
end