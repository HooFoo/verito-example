require 'sidekiq-scheduler'

class InactiveNotificationJob
  include Sidekiq::Worker

  def perform(*args)
    items = Item.where(action: true).where('updated_at <= :time', time: 2.hours.ago).to_a
    orders = Order.where(action: true).where('updated_at <= :time', time: 2.hours.ago).to_a
    proposals = Proposal.where(action: true).where('updated_at <= :time', time: 2.hours.ago).to_a
    all = items + orders + proposals
    all.each do |resource|
      resource.state_notification
    end
  end
end