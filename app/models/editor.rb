class Editor < ActiveRecord::Base
  
  # getter and setter for current editor member
  def self.current
    Thread.current[:editor]
  end

  def self.current=(editor)
    Thread.current[:editor] = editor
  end
  
  def self.not_current
    Editor.where('id != ?', Editor.current)
  end
  
  # password not required for a new user
  def password_required?
    new_record? ? false : super
  end
  
  # exception if we try to delete the last editor
  def raise_if_last
    if Editor.count == 1
      raise "Cannot delete last editor"
    end
  end
  
  def raise_if_last_super
    if Editor.where(:is_super => true).count == 1
      raise "Cannot delete last super editor"
    end
  end
  
  # Devise setup
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :is_super
  
  before_destroy :raise_if_last
  before_destroy :raise_if_last_super
  
  # send instructions to new user
  after_create { |editor| editor.send_reset_password_instructions }
  
end
