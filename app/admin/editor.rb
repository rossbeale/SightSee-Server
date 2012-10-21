ActiveAdmin.register Editor do  
  
  if Editor.count < 2         
    actions :all, :except => [:destroy]       
  else
    actions :all
  end           
  
  index do       
    column :name                     
    column :email                     
    column :current_sign_in_at        
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

  filter :email                       

  form do |f|                         
    f.inputs "Editor Details" do       
      f.input :name
      f.input :email                  
      f.input :is_super, :label => "Super Editor"  
    end                               
    f.buttons                         
  end  
                                
end                                   
