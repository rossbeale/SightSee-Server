class CreateLocations < ActiveRecord::Migration
  
  def change
    create_table :locations do |t|
      t.string  :name
      t.text    :description
      
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10

      t.integer :editor_id

      t.timestamps
    end
    
    add_index :locations, :lat
    add_index :locations, :lng
    add_index :locations, [:lat, :lng]
  end
end