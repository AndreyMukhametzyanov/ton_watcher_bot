class SidekiqServerMiddleware
  def call(worker, job, queue)
    Sidekiq.logger.info "SidekiqServerMiddleware started"
    yield
  end
end