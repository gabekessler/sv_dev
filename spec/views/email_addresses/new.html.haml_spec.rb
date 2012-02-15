require 'spec_helper'

describe "email_addresses/new" do
  before(:each) do
    assign(:email_address, stub_model(EmailAddress,
      :email_address => "MyString"
    ).as_new_record)
  end

  it "renders new email_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => email_addresses_path, :method => "post" do
      assert_select "input#email_address_email_address", :name => "email_address[email_address]"
    end
  end
end
