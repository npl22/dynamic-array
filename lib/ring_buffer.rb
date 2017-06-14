require_relative "static_array"


# you don't have to mod again since you put it in your bracket method

# mod by capacity instead of length?
class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store_index = (@start_idx + index) % @capacity
    @store[store_index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    store_index = (@start_idx + index) % @capacity
    @store[store_index] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length.zero?
    popped_el, self[@length - 1] = self[@length - 1], nil
    @length -= 1
    popped_el
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    resize! if @length > @capacity
    self[@length - 1] = val
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length.zero?
    shifted_el, self[0] = self[0], nil
    @start_idx += 1
    @length -= 1
    shifted_el
  end

  # O(1) ammortized
  def unshift(val)
    @length += 1
    resize! if @length > @capacity
    @start_idx -= 1
    self[0] = val
  end

  # protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @start_idx = 0
    (0...@length-1).each do |i|
      new_store[i] = self[i]
    end
    @store = new_store
  end
end
