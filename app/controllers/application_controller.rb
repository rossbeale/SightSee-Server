class ApplicationController < ActionController::Base  
  protect_from_forgery

  # Override build_footer method in ActiveAdmin::Views::Pages
  require 'active_admin_views_pages_base.rb'
  
  def set_admin_locale 
    I18n.locale = :en_extended
  end 
  
  # sets editor instance of the current editor (so its accessible in the Editor model)
  def set_current_editor
    Editor.current = current_editor
  end
    
  # we set the editor to hide it from the list we are about to fetch
  before_filter :set_current_editor
end
