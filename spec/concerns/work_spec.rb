require 'spec_helper.rb'

describe Canmoia::Work do
  let(:work_order) { Fabricate(:work_order) }

  it 'should include Camnoia::Work module ' do
    work_order.class.included_modules.should include Canmoia::Work
  end

  it 'should include Camnoia::Notification module ' do
    work_order.class.singleton_class.included_modules.should include Canmoia::Notification
  end

  describe 'when marked to notify and notification event triggered' do

    it 'should send email to responsible' do
      work_order.close!
      last_email.should deliver_to work_order.responsible
    end

    # it 'should fail when no mailer is found' do
    #   work_order.close!
    #   last_email.should deliver_to work_order.responsible
    # end

    # it 'should fail when no mail method is found' do
    #   work_order.close!
    #   last_email.should deliver_to work_order.responsible
    # end

  end
end
