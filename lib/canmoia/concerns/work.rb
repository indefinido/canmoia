require 'active_support/concern'

module Canmoia
  module Work
    extend ActiveSupport::Concern

    included do
      include Order
      extend Notification

      # Fields

      # Relations
      belongs_to :responsible, :class_name => "::User"

      # States Notifications
      notify :responsible, :on => [:open, :close]
      notify :client     , :on => [:open, :accept, :reject, :cancel]
    end

    module CalculationMethods
      def total
        @total ||= items.sum(&:value)
      end
    end

    # - on :open   , close: :reviewing, cancel: :canceled, notify: :responsible
    # V on :review, reject: :rejected, accept: :accepted
    # - on :accept, notify: :buyer
    # - on :reject, notify: :buyer
    # - on :cancel, notify: [:buyer, via: :email] }
    # - on :finish, notify: [:buyer, via: :email] }

  end
end
