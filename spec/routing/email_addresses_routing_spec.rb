require "spec_helper"

describe EmailAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/email_addresses").should route_to("email_addresses#index")
    end

    it "routes to #new" do
      get("/email_addresses/new").should route_to("email_addresses#new")
    end

    it "routes to #show" do
      get("/email_addresses/1").should route_to("email_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/email_addresses/1/edit").should route_to("email_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/email_addresses").should route_to("email_addresses#create")
    end

    it "routes to #update" do
      put("/email_addresses/1").should route_to("email_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/email_addresses/1").should route_to("email_addresses#destroy", :id => "1")
    end

  end
end
