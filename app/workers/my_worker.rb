class MyWorker
  include Sidekiq::Job
  sidekiq_options queue: 'my_queue_1'

  def perform(args)
    logger.info "MyJob started"
    sleep(args)
    logger.info "MyJob ended after 10 sec"
  end
end
