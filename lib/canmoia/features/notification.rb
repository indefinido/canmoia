# require 'active_support/concern'

module Canmoia
  module Notification
    # TODO add when needed extend ActiveSupport::Concern

    attr_accessor :notifications_declared

    def self.extended base
      base.notifications_declared = []
    end

    def notify recipient_attribute = :responsible, on: -> { raise "on is required" }, via: :email
      raise "Recipient named as '#{recipient_attribute}' not found for #{self.name}" unless instance_methods.include? recipient_attribute.to_sym

      on.each do |event|
        add_notification_method event, recipient_attribute, via
      end
    end

    private

    # TODO use method missing
    def add_notification_method event, recipient_attribute, via
      mail_method = "#{event}_notification_to_#{recipient_attribute}"

      notification = "#{event}_#{recipient_attribute}".to_sym
      unless notifications_declared.include? notification
        notifications_declared << notification
      else
        raise "Notification for event '#{event}' to recipient '#{recipient_attribute}' already declared!"
      end

      # TODO only define notification method if method is present on mailer
      # TODO create task to generate / update mailer with notification settings

      define_method "#{event}!" do |*args|
        returned = super *args
        # TODO better error message when mailer is not found
        # TODO allow specification of custom mailer
        mailer = "#{self.class.name}Mailer".classify.constantize

        # TODO better error message when mail method is not found
        entity = send recipient_attribute
        mail   = mailer.send mail_method, self, entity

        mail.deliver or returned
      end
    end
  end
end
