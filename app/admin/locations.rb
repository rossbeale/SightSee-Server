ActiveAdmin.register Location do
  
  controller do
    
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
    selectable_column
    column :name                     
    column :description                     
    column :lat           
    column :lng  
    column "Categories" do |location|
      location.categories.map { |category| link_to category.name, edit_category_path(category) }.join('<br />').html_safe
    end
    column "Average Review Score" do |location|
      if location.reviews.count > 0
        location.review_score
      else
        "Not Yet Reviewed"
      end
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
          location.categories.map { |category| link_to category.name, edit_category_path(category) }.join('<br />').html_safe
        end
        row "Reviews" do |location|
          location.reviews.count
        end
        row "Average Review Score" do |location|
          if location.reviews.count > 0
            location.review_score
          else
            "Not yet reviewed"
          end
        end
        row "Reviews" do |location|
          if location.reviews.count > 0
            if location.reviews.with_comments.count > 0
              location.reviews.with_comments.map { |review| link_to "\"#{review.review_comment}\"", edit_review_path(review) }.join('<br />').html_safe
            else
              "No reviews with comments"
            end
          else
            "Not yet reviewed"
          end
        end
        row :created_at
        row :updated_at
      end
    end   
    
    # new/edit form
    form do |f|                         
      f.inputs "Location Details" do
        f.input :editor, :collection => Editor.editors, :include_blank => false
        f.input :name
        f.input :description      
        f.input :lat, :as => :string, :label => "Latitude", :input_html => { :class => 'lat' }
        f.input :lng, :as => :string, :label => "Longitude", :input_html => { :class => 'lng' }
        f.input :categories
      end                               
      f.actions                         
    end  
  
end
