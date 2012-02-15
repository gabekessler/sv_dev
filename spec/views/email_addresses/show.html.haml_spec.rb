require 'spec_helper'

describe "email_addresses/show" do
  before(:each) do
    @email_address = assign(:email_address, stub_model(EmailAddress,
      :email_address => "Email Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email Address/)
  end
end
