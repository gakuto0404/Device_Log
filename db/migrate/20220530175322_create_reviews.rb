class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :user_id
      t.integer :genre_id
      t.string :title
      t.string :item_name
      t.string :manufacture_name
      t.text :impressions
      t.integer :purchase_price
      t.string :purchase_source

      t.timestamps
    end
  end
end
