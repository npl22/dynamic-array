class StaticArray
  def initialize(length)
    @length = length
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' if index >= @length
    @store[index] = value
  end

  protected
  attr_accessor :store
  attr_reader :length
end
