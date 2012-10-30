class Location < ActiveRecord::Base
  
  validates_presence_of :name, :lat, :lng, :categories
  
  belongs_to :editor
  has_many :reviews
  has_and_belongs_to_many :categories
  
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng
                     
  attr_accessible :name, :description, :lat, :lng, :category_ids
  
  def self.recent(limit)
    find(:all, :order => "id desc", :limit => limit).reverse
  end
  
  def review_score
    reviews.average(:review_score)
  end
  
  def validation
    reviews.average(:review_score)
  end
  
  def distance_formatted
      distance.round(2)
  end
  
  def as_json(options={})
    super((options || { }).merge({
        :methods => [:distance_formatted, :categories, :reviews],
        :except => [:editor_id, :created_at, :updated_at]
    }))
  end
  
  # exception if we try to delete the last editor
  def check_location
    if lat > 90 || lat < -90 || lng > 180 || lat < -180
      raise "Incorrect co-ordinates"
    end
  end
  
  before_save :check_location
    
end
