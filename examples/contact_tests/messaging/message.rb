class Message
  attr_reader :to, :from, :key, :mouse

  def initialize(to, from, key, data = nil)
    @to = to
    @from = from
    @key = key
    @data = data
  end
end