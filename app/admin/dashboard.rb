ActiveAdmin.register_page "Dashboard" do
  
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      #   column do
      #     panel "Recent Posts" do
      #       ul do
      #         Post.recent(5).map do |post|
      #           li link_to(post.title, admin_post_path(post))
      #         end
      #       end
      #     end
      #   end
    
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
          table_for Location.recent(10) do
            column("Name")   { |location| location.name } 
            column("Description"){ |location| location.description }
            column("Map") { |location| image_tag("http://maps.google.com/maps/api/staticmap?markers=icon:http://i49.tinypic.com/4jkzmr.png%7Cshadow:false%7C" + location.lat.to_s + "," + location.lng.to_s + "&zoom=16&size=240x80&sensor=false") }
          end
        end
      end
      
      column do
        panel "Recent Reviews" do
          para "Recently added reviews will appear here."
        end
      end
    
    end
    
  end # content
  
end
