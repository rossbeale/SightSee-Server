ActiveAdmin.register Review do
  
  scope_to :current_editor, :association_method => :my_reviews
  
  # order by name, forget about pagination
  config.sort_order = "created_at_desc"
  
  menu :priority => 4
  
  filter :location
  filter :reviewer_name
  filter :review_comment
  filter :review_score
  filter :created_at
  
  actions :all, :except => [:new]
  
  # index table (no download links)
  index do 
    selectable_column      
    column :review_score
    column :review_comment
    column :reviewer_name
    column :created_at
    column "Location" do |location|
      link_to location.location.name, edit_location_path(location.location).html_safe
    end
    default_actions 
  end      
  
  # show table
  show do |category|
    attributes_table do
      row :review_score
      row :review_comment
      row :reviewer_name
      row :created_at
      row "Location" do |location|
        link_to location.location.name, edit_location_path(location.location).html_safe
      end
    end
  end   
    
  # new/edit form
  form do |f|                         
    f.inputs "Review Details" do
      f.input :location
      f.input :reviewer_name
      f.input :review_comment
      f.input :review_score
    end                               
    f.actions                         
  end 
  
end
