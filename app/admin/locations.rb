ActiveAdmin.register Location do
  
  controller do
    
    def set_admin_locale 
      I18n.locale = :en_locations
    end 
    
    def check_categories
      if Category.count == 0
        flash[:failure] = "To add locations, you must have at least one category"
        redirect_to edit_categories_path
      end
    end
    
    before_filter :check_categories
    
  end 
  
  menu :priority => 2
  
  scope_to :current_editor, :association_method => :my_locations
  
  # filters
  filter :name
  filter :categories_id, :as => :check_boxes, :collection => proc { Category.with_locations }
  
  # order by name, forget about pagination
  config.sort_order = "name_desc"
  
  # index table (no download links)
  index do       
    column :name                     
    column :description                     
    column :lat           
    column :lng  
    column "Categories" do |location|
      location.categories.map { |p| p.name }.join('<br />').html_safe
    end
    default_actions 
  end      
  
  # show table
  show do |location|
      attributes_table do
        row :name
        row :description
        row "Latitude" do
          location.lat
        end
        row "Longitude" do
          location.lng
        end
        row "Map" do
          image_tag("http://maps.google.com/maps/api/staticmap?markers=icon:http://i49.tinypic.com/4jkzmr.png%7Cshadow:false%7C" + location.lat.to_s + "," + location.lng.to_s + "&zoom=16&size=500x300&sensor=false")
        end
        row "Categories" do
          location.categories.map { |p| p.name }.join('<br />').html_safe
        end
        row :created_at
        row :updated_at
      end
    end   
    
    # new/edit form
    form do |f|                         
      f.inputs "Location Details" do
        f.input :name
        f.input :description                
        f.input :lat, :label => "Latitude"
        f.input :lng, :label => "Longitude"
        f.input :categories
      end                               
      f.buttons                         
    end  
  
end
