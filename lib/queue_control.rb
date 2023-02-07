class QueueControl
  def self.lock!(queue,delay)
    Sidekiq.redis do |conn|
      conn.set(queue,Time.now + delay.to_i)
    end
  end

  def self.unlock!(queue)
    Sidekiq.redis do |conn|
      conn.del("#{queue}")
    end
  end
end
