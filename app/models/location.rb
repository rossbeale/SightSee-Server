class Location < ActiveRecord::Base
  
  belongs_to :editor
  
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :lat,
                    :lng_column_name => :lng
                     
  attr_accessible :name, :description, :lat, :lng
  
  def self.origin
    @origin
  end

  def self.origin=(value)
    @origin = value
  end
  
  def distance
    distance_from(@origin, :units=>:miles)
  end
  
  def as_json(options={})
    super((options || { }).merge({
        :methods => [:distance],
        :except => [:editor_id, :created_at, :updated_at]
    }))
  end
    
end
