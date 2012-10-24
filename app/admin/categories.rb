ActiveAdmin.register Category do
  
  menu :priority => 3
  
  filter :name
  
  # order by name, forget about pagination
  config.sort_order = "name_desc"
  
  # index table (no download links)
  index do       
    column :name
    column :created_at
    column :updated_at
    if current_editor.is_super?
      column "Linked Locations" do |category|
        category.locations.map { |location| link_to location.name, edit_location_path(location) }.join('<br />').html_safe
      end
    end
    default_actions 
  end      
  
  # show table
  show do |category|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      if current_editor.is_super?
        row "Linked Locations" do |category|
          category.locations.map { |location| link_to location.name, edit_location_path(location) }.join('<br />').html_safe
        end
      end
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
