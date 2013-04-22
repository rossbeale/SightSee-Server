class Review < ActiveRecord::Base
  belongs_to :location
  
  attr_accessible :location_id, :reviewer_name, :review_comment, :review_score, :uid
  
  validates :location_id, :presence => true
#  validates :uid, :presence => true
  
  def display_name
    "Review for \"" + location.name + "\""
  end
    
  # exception if we try to delete the last editor
  def check_score
    if review_score > 5
      raise "Cannot give a review higher than 5.0"
    end
  end
  
  def self.with_comments
    where('review_comment != \'\' OR review_comment != NULL')
  end
  
  def self.recent(limit)
    find(:all, :order => "id asc", :limit => limit).reverse
  end
  
  def review_score_dashboard_class
    if review_score < 3
      "status_tag red"
    else
      "status_tag green"
    end
  end
  
  def created_date
    created_at.to_time.to_i
  end
  
  before_save :check_score
  
  def id_as_json()
    as_json({
        :only => [:id]
    })
  end
  
  def response
    "success"
  end
  
  def as_json(options={})
    super((options || { }).merge({
        :methods => [:response, :created_date],
        :except => [:created_at, :updated_at, :location_id]
    }))
  end
  
end
