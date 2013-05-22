require "spec_helper"

describe NotifiableOrderMailer do
  describe "close_notification_to_responsible" do
    let(:mail) {
      order = Fabricate :order
      NotifiableOrderMailer.close_notification_to_responsible order, order.responsible
    }

    it "renders the headers" do
      mail.subject.should eq("Close notification to responsible")
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
