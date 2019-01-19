require_relative 'messages.rb'

class GameObject
  include Messages

  def initialize
    @messages = Hash.new { |hash, key| hash[key] = Array.new }
  end
end