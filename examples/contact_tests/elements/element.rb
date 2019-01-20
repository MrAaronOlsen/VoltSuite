class Element
  include Messaging

  def initialize
    @messages = Hash.new { |hash, key| hash[key] = Array.new }
  end
end