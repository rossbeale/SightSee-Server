class Editor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  def self.current
    Thread.current[:editor]
  end

  def self.current=(editor)
    Thread.current[:editor] = editor
  end
  
  scope :editors, where('id != ?', Editor.current)

  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :is_super
  # attr_accessible :title, :body
  
  after_create { |editor| editor.send_reset_password_instructions }
    
  def password_required?
    new_record? ? false : super
  end
    
  before_destroy :raise_if_last
  
  def raise_if_last
    if Editor.count == 1
      raise "Can't delete last admin user"
    end
  end
    
end
