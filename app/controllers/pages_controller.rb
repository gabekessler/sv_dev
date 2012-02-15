class PagesController < ApplicationController
  
  def home
    @page = Page.find(1)
    @email = EmailAddress.new
    render :layout => 'home'
  end
  
  def authorize
    # DO STUFF WITH FB CALLBACK
  end
  
  def thank_you
    render :layout => 'home'
  end
  
end
