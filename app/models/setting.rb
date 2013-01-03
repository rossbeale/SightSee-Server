class Setting < ActiveRecord::Base
  attr_accessible :var, :value
  
  def display_name
    var.capitalize
  end
    
  # exception if we try to delete the last editor
  def check_value
    if var == "limit" && value.to_i < 1
      raise "Limit should be at least 1"
    end
  end
  
  def self.get_encrypt
    @encrypt_setting = find_by_var("encrypt")
    if @encrypt_setting.value.to_i == 1
      true
    else
      false
    end
  end
  
  def self.get_limit
    @limit_setting = find_by_var("limit")
    @limit_setting.value.to_i
  end
  
  before_save :check_value
end
