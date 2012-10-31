class Review < ActiveRecord::Base
  belongs_to :location
  
  attr_accessible :location_id, :reviewer_name, :review_comment, :review_score
  
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
  
  before_save :check_score
  
  def as_json(options={})
    super((options || { }).merge({
        :except => [:updated_at, :location_id]
    }))
  end
  
end
