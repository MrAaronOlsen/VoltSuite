class Element
  include Messaging

  def initialize
    @messages = Hash.new
  end
end