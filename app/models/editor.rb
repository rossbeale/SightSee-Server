class Editor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :is_super
  # attr_accessible :title, :body
  
  after_create { |admin| admin.send_reset_password_instructions }
    
  def password_required?
    new_record? ? false : super
  end
    
  before_destroy :raise_if_last
  
  def raise_if_last
    if AdminUser.count < 2
      raise "Can't delete last admin user"
    end
  end
    
end
