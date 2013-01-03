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
    end

    columns do
      
      column do
        panel "Recent Locations" do
          @locations = Location.recent(10)
          if @locations.count > 0
            table_for @locations do
              column("Name")        { |location| location.name } 
              column("Description") { |location| location.description }
              column("Score")       { |location| span :class => location.review_score_dashboard_class do location.review_score_string(false) end }
            end
          else
            para "No locations have yet been added."
          end
        end
      end
      
      column do
        panel "Recent Reviews" do
          @reviews = Review.recent(10)
          if @reviews.count > 0
            table_for @reviews do
              column("Location")   { |review| review.location.name } 
              column("Comment")   { |review| review.review_comment } 
              column("Score"){ |review| span :class => review.review_score_dashboard_class do review.review_score end }
             end
          else
            para "No reviews have yet been added."
          end
        end
      end
    
    end # columns
    
  end # content
  
end
