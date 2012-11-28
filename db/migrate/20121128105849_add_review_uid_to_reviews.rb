class AddReviewUidToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :uid, :string
  end
end
