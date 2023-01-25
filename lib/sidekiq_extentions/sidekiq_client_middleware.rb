class SidekiqClientMiddleware
  def call(worker, job, queue, redis_pool)
    if Sidekiq.redis { |conn| conn.get(queue) }
      Rails.logger.info "SidekiqClientMiddleware started"
      sleep (Sidekiq.redis { |conn| conn.get(queue) }).to_i
      Rails.logger.info "SidekiqClientMiddleware after sleep"
    end
    yield
  end
end
