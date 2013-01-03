class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document
 
  private
 
  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para "Created by Ross Beale (#{link_to('cp004138@reading.ac.uk', 'mailto:cp004138@reading.ac.uk')}), #{Date::MONTHNAMES[Date.today.month]} #{Date.today.year.to_s}. Powered by #{link_to('Active Admin', 'http://www.activeadmin.info')} #{ActiveAdmin::VERSION}".html_safe
    end
  end
 
end