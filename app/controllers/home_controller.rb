class HomeController < ApplicationController
  
  before_filter :authenticate_editor!
  
  def index
  end
  
  def admin
  end
  
end