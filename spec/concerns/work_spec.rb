require 'spec_helper.rb'

describe Canmoia::Work do

  it 'should define core domain states for Work Order' do
    work_order = Fabricate :order
    work_order.should respond_to :opened?
    work_order.should respond_to :reviewing?
    work_order.should respond_to :accepted?
    work_order.should respond_to :rejected?
    work_order.should respond_to :canceled?
    work_order.should respond_to :completed?
  end

  it 'should compute total value' do
    work_order = Fabricate :accepted_order
    work_order.items.sum(&:value).should == work_order.total
  end

  describe 'when marked to notify' do
    before :all do
      class NotifiableOrder < ::Order
        notify :responsible, on: [:close]
      end
    end

    let(:work_order) { NotifiableOrder.new responsible: Fabricate(:responsible) }

    it 'should send email to responsible' do
      work_order.close!
      last_email.should deliver_to work_order.responsible
    end

    # it 'should fail when no mailer is found' do
    #   work_order.close!
    #   last_email.should deliver_to order.responsible
    # end

    # it 'should fail when no mail method is found' do
    #   work_order.close!
    #   last_email.should deliver_to order.responsible
    # end

  end

  # it 'should not compute total value when completed' do

  # it 'should ignore workflow_column call if workflow_column already called'
end
