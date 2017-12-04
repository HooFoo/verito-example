require 'sidekiq-scheduler'

class RemoveIncorrectPhotosJob
  include Sidekiq::Worker

  def perform(*args)
    photos = Photo.where(item_id: nil, proposal_id: nil)
                 .where('created_at <= :fifteen_minutes_ago', fifteen_minutes_ago: 20.minutes.ago)
    photos.destroy_all
  end
end