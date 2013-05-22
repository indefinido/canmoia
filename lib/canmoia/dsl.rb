module Canmoia::DSL

  def notify entity_name = :responsible, on: -> { raise "on is required" }, via: :email
    raise "Recipient named as '#{entity_name}' not found for #{self.name}" unless instance_methods.include? entity_name.to_sym

    on.each do |event|
      add_notification_method event, entity_name, via
    end
  end

  private

  # TODO use method missing
  def add_notification_method event, entity_name, via
    mail_method = "#{event}_notification_to_#{entity_name}"

    define_method "#{event}!" do |*args|
      returned = super *args
      # TODO better error message when mailer is not found
      # TODO allow specification of custom mailer
      mailer = "#{self.class.name}Mailer".classify.constantize

      # TODO better error message when mail method is not found
      entity = send entity_name
      mail   = mailer.send mail_method, self, entity

      mail.deliver or returned
    end
  end

  # - on :open   , close: :reviewing, cancel: :canceled, notify: :responsible
  # V on :review, reject: :rejected, accept: :accepted
  # - on :accept, notify: :buyer
  # - on :reject, notify: :buyer
  # - on :cancel, notify: [:buyer, via: :email] }
  # - on :finish, notify: [:buyer, via: :email] }

end
