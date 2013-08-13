require 'active_support/concern'

module Canmoia
  module Order
    extend ActiveSupport::Concern

    included do
      include ::Workflow
      include CalculationMethods
      # extend  Notification

      # Fields
      # TODO move to Canmoia::Purchase
      field :state, type: Symbol
      field :total, type: Float

      # Relations
      embeds_many :items

      # TODO move to Canmoia::Purchase
      belongs_to :client, :class_name => "::User"

      # Domain Callbacks
      before_validation :calculate_total, :if => :opened?

      # States
      workflow_column :state
      workflow do

        state :opened do
          event :close , transitions_to: :reviewing
          event :cancel, transitions_to: :canceled
        end

        state :reviewing do
          event :accept, transitions_to: :accepted
          event :reject, transitions_to: :rejected

          event :cancel, transitions_to: :canceled
        end

        state :accepted do
          event :complete, transitions_to: :completed
          event :cancel  , transitions_to: :canceled
        end

        state :rejected do
          event :complete, transitions_to: :completed
          event :cancel  , transitions_to: :canceled
        end

        state :completed
        state :canceled
      end
    end

    module CalculationMethods
      def calculate_total
        self.total = items.sum &:value
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
