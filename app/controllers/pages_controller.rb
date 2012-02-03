class PagesController < ApplicationController
  
  def home
    logger.debug { "HOME PAGE" }
    @page = Page.find(1)
  end
  
end
