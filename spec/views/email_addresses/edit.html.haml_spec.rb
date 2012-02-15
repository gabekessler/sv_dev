require 'spec_helper'

describe "email_addresses/edit" do
  before(:each) do
    @email_address = assign(:email_address, stub_model(EmailAddress,
      :email_address => "MyString"
    ))
  end

  it "renders the edit email_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => email_addresses_path(@email_address), :method => "post" do
      assert_select "input#email_address_email_address", :name => "email_address[email_address]"
    end
  end
end
