module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def clear_emails
    ActionMailer::Base.deliveries = []
  end
end
