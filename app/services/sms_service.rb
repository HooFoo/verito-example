class SmsService
  include Sidekiq::Worker

  @@blower = RestClient::Resource.new(ENV['BLOWERIO_URL'])

  def self.send_to(to,body)
    Rails.logger.debug " --- \n\n  Sms text: #{body} \n\n ---"
    @@blower['/messages'].post(to: to, message: body) if Rails.env == 'production'
  end
end