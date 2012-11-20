class CreateSettings < ActiveRecord::Migration
  
  def migrate(direction)
    super
    # Create default settings
    Setting.create!(:var => 'encrypt', :value => '1') if direction == :up
    Setting.create!(:var => 'limit', :value => '50') if direction == :up
  end
  
  def self.up
    create_table :settings do |t|
      t.string :var, :null => false
      t.text   :value, :null => true
      t.timestamps
    end
    
    add_index :settings, :var, :unique => true
  end

  def self.down
    drop_table :settings
  end
end
