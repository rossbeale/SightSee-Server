ActiveAdmin.register Editor, as: 'Account' do
  actions :edit, :update

  menu label: 'Manage Your Account'

  controller do
    def redirect_to_edit
      redirect_to edit_edit_account_path current_editor
    end

    alias_method :index, :redirect_to_edit
    alias_method :show,  :redirect_to_edit
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