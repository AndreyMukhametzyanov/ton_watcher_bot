class QueueControl
  def self.lock!(queue,delay)
    Sidekiq.redis do |conn|
      conn.set('queue',queue)
      conn.set('delay',delay)
    end
  end

  def self.unlock!(queue)
    redis = Redis.new
    redis.set('queue',queue)
    redis.set('delay','0')
  end
end
