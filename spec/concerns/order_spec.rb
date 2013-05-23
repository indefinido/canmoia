require 'spec_helper.rb'

describe Canmoia::Order do

  it 'should include Camnoia::Order module ' do
    order = Fabricate :order
    order.class.included_modules.should include Canmoia::Order
  end

  it 'should define core domain states for a Order' do
    order = Fabricate :order # Order class must include Canmoia::Order
    order.should respond_to :opened?
    order.should respond_to :reviewing?
    order.should respond_to :accepted?
    order.should respond_to :rejected?
    order.should respond_to :canceled?
    order.should respond_to :completed?
  end

  it 'should compute total value in opened state ' do
    order = Fabricate :order
    first_item = order.items.first

    order.items.sum(&:value).should == order.total

    first_item.value += 1

    order.items.sum(&:value).should == order.total + 1
  end

  it 'should not compute total value after opened state' do
    order = Fabricate :order
    first_item = order.items.first

    order.close!

    closed_total = order.total

    first_item.value += 1

    order.total.should == closed_total
  end

  # it 'should ignore workflow_column call if workflow_column already called'
end
