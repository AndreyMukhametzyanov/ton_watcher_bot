class QueueControl
  def self.lock!(queue,delay)
    Sidekiq.redis { |conn| conn.set(queue,delay) }
  end

  def self.unlock!(queue)
    Sidekiq.redis { |conn| conn.set(queue, 0) }
  end
end
