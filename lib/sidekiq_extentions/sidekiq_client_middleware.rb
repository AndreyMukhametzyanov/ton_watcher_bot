class SidekiqClientMiddleware
  def call(worker, job, queue, redis_pool)
    Rails.logger.info "SidekiqClientMiddleware started"
    yield
  end
end
