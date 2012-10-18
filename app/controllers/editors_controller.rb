class EditorsController < ApplicationController
  
  def index
    @editors = Editor.all
  end
  
end
