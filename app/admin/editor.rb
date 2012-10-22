ActiveAdmin.register Editor do  

  # customise the controller
  controller do
    
    # if not supereditor, lets redirect to dashboard
    def require_super
      if !current_editor.is_super?
        redirect_to edit_dashboard_path
      end
    end
    
    # sets editor instance of the current editor (so its accessible in the Editor model)
    def set_current_editor
      if !Editor.current
        Editor.current = current_editor
        redirect_to edit_editors_path
      end
    end
    
    # custom locale for this page
    def set_admin_locale 
      I18n.locale = :en_extended
    end 
      
    # we can only manage editors if we are a supereditor
    before_filter :require_super
    
    # we set the editor to hide it from the list we are about to fetch
    before_filter :set_current_editor
    
  end

  scope :editors, :default => true do |example|
      Editor.not_current
  end

  # hide from menu if you are not a supereditor
  menu :if => proc{ current_editor.is_super? }
  
  # order by name, forget about pagination
  config.sort_order = "name_desc"
  config.paginate = false
  
  # filters
  filter :name
  filter :email
  
  # index table (no download links)
  index :download_links => false do       
    column :name                     
    column :email                     
    column :last_sign_in_at           
    column :sign_in_count  
    column :is_super  
    default_actions 
  end      
  
  # show table
  show do
    attributes_table :name, 
                     :email, 
                     :is_super,
                     :current_sign_in_at, 
                     :last_sign_in_at, 
                     :sign_in_count, 
                     :current_sign_in_ip, 
                     :last_sign_in_ip, 
                     :created_at, 
                     :updated_at
  end                                                

  # new/edit form
  form do |f|                         
    f.inputs "Editor Details" do       
      f.input :name
      f.input :email                
      f.input :is_super, :label => "Super Editor"  
    end                               
    f.buttons                         
  end  
                                
end