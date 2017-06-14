require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store, :maxqueue

  def initialize
    @store = RingBuffer.new
    @maxqueue = RingBuffer.new
  end

  # Only 2 pushes, so it's constant, not with respect to O(n)
  def enqueue(el)
    @maxqueue.push(el) if @maxqueue.length.zero?

    @store.push(el)
    while @maxqueue[0] < el
      @maxqueue.pop
      break if @maxqueue.length.zero?
    end
    @maxqueue.push(el)
  end

  def dequeue
    val = @store.shift
    @maxqueue.shift if val == @maxqueue[0]
    val
  end

  def max
    @maxqueue[0]
  end

  def length
    @store.length
  end
end

# Goal, you want to know what the maximum value of the queue at all times
# two instances of a ring buffer, one for the queue, one for the max
# q = QueueWithMax
# q.max --> max in O(1) time instead of arr.max which is O(n) time

# dequeueing is easy, enqueueing can be constant time amortized, once
# you get a new max, pop off all of the numbers less than the max and
# then push it into the maxqueue. This way the max will always be the
# first element and you can look it up in constant time. This is O(1)
# amortized because you only pop in O(n) when you get a new max. Pushes
# with numbers less than the current max are "free"
