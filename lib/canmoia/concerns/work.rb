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
  end
end
