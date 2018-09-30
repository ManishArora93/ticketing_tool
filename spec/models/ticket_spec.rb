require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:all) do
    ticket1 = Ticket.create(:name => 'ticket1',:description => 'sample ticket1', :severity => 'Severity 1', :status => 'open')
    ticket2 = Ticket.create(:name => 'ticket2',:description => 'sample ticket2', :severity => 'Severity 1', :status => 'open')
    let(:ticket_ids) { [ticket1.id, ticket2.id] }
  end
  
  describe "to_csv" do

    let(:data) { "id\tname\tdescription\tcustomer_id\tassociate_id\tcreated_at\t\rid\tname2\tdescription2\tcustomer_id2\tassociate_id2\tcreated_a2t\t\r"}
    let(:result) {[["Ticket_ID","Ticket Name","Ticket Description","Customer Username","Handled by Associate","Created AT"] }

    it "should read in the csv" do
      CSV.should_receive(:read).
        with("filename", :row_sep => "\r", :col_sep => "\t")
      ticket.to_csv("filename")
    end

    it "should have result" do
      filename = mock(File, :exists? => true, :read => data)
      ticket.to_csv(filename).should eq(result)
    end
  end
end
