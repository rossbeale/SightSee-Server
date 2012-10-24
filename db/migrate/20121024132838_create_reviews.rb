class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      
      t.string :reviewer_name
      t.text :review_comment
      t.float :review_score

      t.integer :location_id
      
      t.timestamps
    end
  end
end
