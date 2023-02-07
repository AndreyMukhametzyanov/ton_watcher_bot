class SidekiqServerMiddleware
  def call(worker, job, queue)
    Sidekiq.logger.info "SidekiqServerMiddleware started"

    delay = Sidekiq.redis { |conn| conn.get(queue) }

    if delay.nil?
      yield
    else
      end_time = (Sidekiq.redis { |conn| conn.get("#{queue}") }).to_time

      if Time.now < end_time
        Object.const_get(job['class']).perform_in(end_time, *job['args'])
        Rails.logger.info "SidekiqClientMiddleware will be started in #{delay}"
      else
        Sidekiq.redis {|conn| conn.del("#{queue}")}
        Rails.logger.info "#{queue} was deleted "
        yield
      end
    end
    Rails.logger.info "SidekiqClientMiddleware finished"
  end
end