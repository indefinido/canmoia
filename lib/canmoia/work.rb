module Canmoia
  module Work
    def self.included base
      base.instance_exec &@domain
      base.extend DSL
    end


    @domain = lambda do
      include ::Workflow

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

      field :total, type: Float
      field :state, type: Symbol

      embeds_many :items
      belongs_to :responsible, :class_name => "::Employee"
      validates_presence_of :responsible
    end

    # Instance methods
    def total
      @total ||= items.sum(&:value)
    end


    # - on :open   , close: :reviewing, cancel: :canceled, notify: :responsible
    # V on :review, reject: :rejected, accept: :accepted
    # - on :accept, notify: :buyer
    # - on :reject, notify: :buyer
    # - on :cancel, notify: [:buyer, via: :email] }
    # - on :finish, notify: [:buyer, via: :email] }

  end
end
