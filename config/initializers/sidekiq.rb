Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: "zalogika_sidekiq_#{Rails.env}",  network_timeout: 5 }

end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: "zalogika_sidekiq_#{Rails.env}",  network_timeout: 5 }
end

Sidekiq::Extensions.enable_delay!