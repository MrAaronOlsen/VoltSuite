require 'simplecov'
SimpleCov.start do
  add_filter('/spec/')
  add_filter('/manifest.rb')
end

require './master_manifest.rb'
require 'be_within_vect.rb'

require 'rspec'
require 'pry'

RSpec::configure do |config|
  config.include(BeWithinVect)
end