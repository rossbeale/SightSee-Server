ActiveAdmin.register Editor do  
  
  menu :if => proc{ current_editor.is_super? }
  
  controller do
    
    before_filter :require_super
      
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
  
  if Editor.count < 2         
    actions :all, :except => [:destroy]       
  else
    actions :all
  end         
  
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
      f.input :password                 
      f.input :is_super, :label => "Super Editor"  
    end                               
    f.buttons                         
  end  
                                
end                                   
