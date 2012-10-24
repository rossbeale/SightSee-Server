ActiveAdmin.register_page "Dashboard" do
  
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      
      column do
        panel "Info" do
          if current_editor.is_super?
            para "Welcome to TourDroid Server - here you can manage locations, reviews and other editors."
          else
            para "Welcome to TourDroid Server - here you can manage locations and reviews."
          end
        end
      end

      column do
        panel "Recently Added Locations" do
          @locations = Location.recent(10)
          if @locations.count > 0
            table_for @locations do
              column("Name")   { |location| location.name } 
              column("Description"){ |location| location.description }
              column("Map") { |location| image_tag("http://maps.google.com/maps/api/staticmap?markers=icon:http://i49.tinypic.com/4jkzmr.png%7Cshadow:false%7C" + location.lat.to_s + "," + location.lng.to_s + "&zoom=16&size=240x80&sensor=false") }
            end
          else
            para "No locations have yet been added."
          end
        end
      end
      
      column do
        panel "Recently Added Reviews" do
          @reviews = Review.recent(10)
          if @reviews.count > 0
            table_for @reviews do
              column("Location Name")   { |review| review.location.name } 
              column("Score"){ |review| review.review_score }
             end
          else
            para "No reviews have yet been added."
          end
        end
      end
    
    end # columns
    
  end # content
  
end
