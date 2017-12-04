require 'sidekiq-scheduler'

class OrdersMonitorJob
  include Sidekiq::Worker

  def perform(*args)
    orders = Order.where(aasm_state: %w(in_progress payment))
                  .where('created_at <= :fifteen_minutes_ago', fifteen_minutes_ago: 15.minutes.ago)
    orders.map &:reject
  end
end
