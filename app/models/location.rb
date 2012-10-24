class Location < ActiveRecord::Base
  
  belongs_to :editor
  has_many :reviews
  has_and_belongs_to_many :categories
  
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng
                     
  attr_accessible :name, :description, :lat, :lng, :category_ids
  
  def self.origin
    @origin
  end

  def self.origin=(value)
    @origin = value
  end
  
  def self.recent(limit)
    find(:all, :order => "id desc", :limit => limit).reverse
  end
  
  def distance
    distance_from(@origin, :units=>:miles)
  end
  
  def review_score
    reviews.average(:review_score)
  end
  
  def as_json(options={})
    super((options || { }).merge({
        :methods => [:distance, :categories, :reviews],
        :except => [:editor_id, :created_at, :updated_at]
    }))
  end
    
end
