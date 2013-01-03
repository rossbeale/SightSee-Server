ActiveAdmin.register Setting, as: 'Setting' do

  # hide from menu if you are not a supereditor
  menu :if => proc{ current_editor.is_super? }, :priority => 6
  
  actions :all, :except => [:new, :create, :destroy]

  before_filter { @skip_sidebar = true }
  config.paginate = false
  config.batch_actions = false
  
  controller do

    # if not supereditor, lets redirect to dashboard
    def require_super
      if !current_editor.is_super?
        redirect_to edit_dashboard_path
      end
    end
  
    # we can only manage editors if we are a supereditor
    before_filter :require_super

  end
  
  # index table (no download links)
  index :download_links => false do    
    column "Setting", :var
    column "Value", :value, :sortable => false
    default_actions
  end  

  # edit form
  form do |f|               
    f.inputs "Edit Setting" do       
      if setting.var == "encrypt"
        f.input :value, :as => :boolean, :label => "Use Encyption"  
      else
        f.input :value, :as => :number, :label => "Location Limit"  
      end
    end                               
    f.actions                         
  end  
  
end