class PagesController < ApplicationController
  
  def home
    @page = Page.find(1)
  end
  
end
