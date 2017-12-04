class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@verito.ru'
  layout 'mailer'

  def notification_email(to,subject,text)
    @to = to
    @subject = subject
    @text = text
    mail(to: to, subject: subject)
  end

end
