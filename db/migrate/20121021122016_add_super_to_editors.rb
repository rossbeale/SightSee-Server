class AddSuperToEditors < ActiveRecord::Migration
  def change
    add_column :editors, :is_super, :boolean, :default => false
    add_index :editors, :is_super, :unique => false
  end
end
