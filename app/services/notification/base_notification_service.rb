class Notification::BaseNotificationService
  def self.notify(to, subject, text,resource_type)
    mailer = "#{resource_type}sMailer".constantize
    if to.class == Array
      to.each do |address|
        send_mail(address, subject, text, mailer)
      end
    else
      send_mail(to, subject, text, mailer)
    end
  end

  def self.make_notification(resource)
    raise NotImplementedError
  end

  private

  def self.send_mail(address, subject, text, mailer)
    mailer.notification_email(address, subject,text).deliver_later
  end
end