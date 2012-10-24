class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :categories_locations, :id => false do |t|
        t.references :location
        t.references :category
    end
    
    add_index :categories_locations, [:location_id, :category_id]
    add_index :categories_locations, [:category_id, :location_id]
    
  end
end
