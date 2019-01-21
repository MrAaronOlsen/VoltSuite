class Message
  attr_accessor :to, :from, :key, :data

  def initialize(to, from, key, data = nil)
    @to = to
    @from = from
    @key = key
    @data = data
  end
end