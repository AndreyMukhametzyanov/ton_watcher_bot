# frozen_string_literal: true

require 'sidekiq-scheduler'

class User < ApplicationRecord
  after_update :set_delay

  validates :external_id, presence: true, uniqueness: true

  private

  def set_delay
    Sidekiq.set_schedule("AddSendDelayWorker#{id}", { 'cron' => send_period.to_s,
                                                      'class' => 'AddSendDelayWorker', 'args' => id })
  end
end
