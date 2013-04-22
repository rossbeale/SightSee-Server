ActiveAdmin.register Editor, as: 'Account' do
  actions :edit, :update

  menu label: 'Manage Your Account'

  controller do
    def redirect_to_edit
      redirect_to edit_edit_account_path current_editor
    end
    
    # if not current users path, lets redirect to their own
    def is_editors_account
      puts params[:id]
      puts current_editor.id
      if params[:id].to_i != current_editor.id.to_i
        redirect_to_edit
      end
    end

    alias_method :index, :redirect_to_edit
    alias_method :show,  :redirect_to_edit
    
    # we can only manage our own account
    before_filter :is_editors_account
    
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end
end