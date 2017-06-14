# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

# Goal, you want to know what the maximum value of the queue at all times
# two instances of a ring buffer, one for the queue, one for the max
# q = QueueWithMax
# q.max --> max in O(1) time instead of arr.max which is O(n) time

# enqueue onto the Queue, don't enqueue but push onto the MaxQueue

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @maxqueue = RingBuffer.new
  end

  # Only 2 pushes, so it's constant, not with respect to O(n)
  def enqueue(val)
    @store.push(val)
  end

  def dequeue
    @store.pop
  end

  def max
  end

  def length
    @length = @store.length
  end

end
