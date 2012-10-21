ActiveAdmin.register Editor do  

  scope :editors, :default => true

  menu :if => proc{ current_editor.is_super? }
  
  controller do
    
    before_filter :set_current_editor
    
    before_filter :require_super
    
    def set_admin_locale 
      I18n.locale = :en_extended
    end 
    
    def set_current_editor
      Editor.current = current_editor
    end
      
    def require_super
      if !current_editor.is_super?
        redirect_to edit_dashboard_path
      end
    end
    
  end
  
  config.sort_order = "name_desc"
  config.paginate = false
  
  filter :name
  filter :email
  
  index :download_links => false do       
    column :name                     
    column :email                     
    column :last_sign_in_at           
    column :sign_in_count  
    column :is_super  
    default_actions 
  end      
  
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

  form do |f|                         
    f.inputs "Editor Details" do       
      f.input :name
      f.input :email                
      f.input :is_super, :label => "Super Editor"  
    end                               
    f.buttons                         
  end  
                                
end                                   
