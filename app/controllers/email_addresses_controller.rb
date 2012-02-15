class EmailAddressesController < InheritedResources::Base
  
  def index
    @emails = EmailAddresses.all
  end
  
  def new
    @email = EmailAddress.new
  end
  
  def create
    @email = EmailAddress.new(params[:email_address])
    
    respond_to do |format|
      if @email.save
        format.html { redirect_to thank_you_url, :message => "thanks buddy" }
        format.json { render json: @email, status: :created, location: @email }
      else
        format.html { redirect_to root_url, :error => "There was a problem with your email. Please try again." }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end
end
