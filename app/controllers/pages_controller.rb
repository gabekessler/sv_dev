class PagesController < ApplicationController
  
  def home
    @page = Page.find(1)
  end
  
  def authorize
    # DO STUFF WITH FB CALLBACK
  end
  
end
