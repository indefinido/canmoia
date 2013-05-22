class NotifiableOrderMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifiable_order_mailer.close_notification_to_responsible.subject
  #
  def close_notification_to_responsible order, responsible
    @greeting = "Hi"

    mail to: order.responsible.email
  end
end
