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
        panel "Recent Locations" do
          para "Recently added locations will appear here."
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
