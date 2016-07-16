class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.string :genre
      t.string :rating
      t.integer :critic_id
    end
  end
end
