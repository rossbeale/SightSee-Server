class Location < ActiveRecord::Base
  
  validates_presence_of :name, :lat, :lng, :categories, :editor
  
  belongs_to :editor
  has_many :reviews
  has_and_belongs_to_many :categories
  
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng
                     
  attr_accessible :name, :description, :lat, :lng, :category_ids, :editor_id
  
  def self.recent(limit)
    find(:all, :order => "id asc", :limit => limit).reverse
  end
  
  def review_score
    reviews.average(:review_score).round(1)
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
    if lat > 90 || lat < -90 || lng > 180 || lng < -180
      raise "Incorrect co-ordinates"
    end
  end
  
  def check_editor
    if !Editor.current.is_super?
      if editor_id != Editor.current.id
        raise "Wrong editor"
      end
    end
  end
  
  before_save :check_location
  before_save :check_editor
    
end
