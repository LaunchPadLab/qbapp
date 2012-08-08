class PagesController < ApplicationController
  
  def home
    @title = "QB | Home"
  end
  
  def dashboard
    @title = "QB | Dashboard"
  end
  
  
end