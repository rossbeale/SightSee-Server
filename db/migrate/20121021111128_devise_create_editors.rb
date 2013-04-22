class DeviseCreateEditors < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default editor
    Editor.create!(:name => 'Ross Beale', :email => 'cp004138@reading.ac.uk', :password => 'password', :password_confirmation => 'password', :is_super => true) if direction == :up
  end

  def change
    create_table(:editors) do |t|
      ## Database authenticatable
      t.string :name,               :null => false, :default => ""
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      
      t.boolean :is_super,          :default => false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :editors, :name,                 :unique => false
    add_index :editors, :email,                :unique => true
    add_index :editors, :reset_password_token, :unique => true
  end
end
