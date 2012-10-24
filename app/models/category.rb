class Category < ActiveRecord::Base
  has_and_belongs_to_many :locations
  
  attr_accessible :name
  
  def self.with_locations
    categories_with_locations = []
    categories = Category.all
    categories.each do |category|
      if category.locations.count > 0
        categories_with_locations << category
      end
    end
    categories_with_locations
  end
  
  def as_json(options={})
    super((options || { }).merge({
        :except => [:created_at, :updated_at]
    }))
  end
  
end
