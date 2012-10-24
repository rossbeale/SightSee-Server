ActiveAdmin.register Category do
  
  controller do
    
    def set_admin_locale 
      I18n.locale = :en_locations
    end 
    
  end 
  
  filter :name
  
  actions :all, :except => [:show]
  
  # order by name, forget about pagination
  config.sort_order = "name_desc"
  
  # index table (no download links)
  index do       
    column :name
    column :created_at
    column :updated_at
    default_actions 
  end      
  
  # show table
  show do |category|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end   
    
  # new/edit form
  form do |f|                         
    f.inputs "Category Details" do
      f.input :name
    end                               
    f.buttons                         
  end 
  
end
