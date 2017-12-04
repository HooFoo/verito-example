class Notification::CourierNotificationService < Notification::BaseNotificationService
  def self.make_notification(resource)
    if resource.courier
      to = resource.admin_user.email
      resource_type = resource.class.to_s.downcase
      link_method = "courier_#{resource_type}_url"
      link = Rails.application.routes.url_helpers.send(link_method, resource)
      subject = "#{I18n.t('email.notifications.courier.subject')}: #{resource.to_s}"
      text = "#{I18n.t('email.notifications.courier.text')} <\br> #{I18n.t('email.notifications.courier.link')} #{ActionController::Base.helpers.link_to(link)}".html_safe
      mailer = CouriersMailer
      send_mail(to, subject,text,mailer)
    end
  end
end