class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :text_content
      t.integer :likes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
