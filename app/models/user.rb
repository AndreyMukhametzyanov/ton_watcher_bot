require 'sidekiq-scheduler'

class User < ApplicationRecord
  after_update :set_delay

  private

  def set_delay
    Sidekiq.set_schedule('AddSendDelayWorker', { 'every' => '10s', 'class' => 'AddSendDelayWorker' })
  end

end
