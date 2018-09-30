require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  
  before(:all) do
      @admin = User.create!(email: 'user@web2labs.net', password: 'web2labs').make_as_admin
      @associate = User.create!(email: 'associate@web2labs.net', password: 'web2labs').make_as_associate
      @tickets = Ticket.all
    end

  describe "GET #index" do
    
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the tickets if user is :admin" do
      let(:current_user) {@admin}
      get :index

      expect(assigns(:tickets)).to match_array(@tickets)
    end

    it "loads all of the tickets if user is :associate" do
      let(:current_user) {@associate}
      get :index

      expect(assigns(:tickets)).to match_array(@tickets)
    end
  end
  
  describe "get_all_tickets" do
     it "loads all of the tickets" do
       expect(assigns(:tickets)).to match_array(@tickets)
     end
  end
  
  describe "show" do
     it "renders the show template" do
       expect(response).to render_template("show")
     end
  end
  
  describe "edit" do
     it "renders the edit template" do
       expect(response).to render_template("edit")
     end
  end
  
  describe "new" do
     it "renders the new template" do
       expect(response).to render_template("new")
     end
  end
  
  describe "create" do
     it "create the new ticket" do
       ticket1 = Ticket.create(:name => 'ticket1',:description => 'sample ticket', :severity => 'Severity 1', :status => 'open')
       let(:ticket_params) {:name => 'ticket1',:description => 'sample ticket', :severity => 'Severity 1', :status => 'open'}
       post :create
       expect(assigns(:ticket)).to eq(ticket1)
     end
  end
  
  describe "destroy" do
     it "destroy a ticket" do
       delete :destroy
       expect(assigns(:ticket)).to eq(nil)
     end
  end
end


end
