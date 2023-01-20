class SidekiqClientMiddleware
  def call(worker, job, queue, redis_pool)
    Rails.logger.info "SidekiqClientMiddleware started"
    queue =
    sleep 30
    Rails.logger.info "SidekiqClientMiddleware after sleep"
    yield
  end
end
