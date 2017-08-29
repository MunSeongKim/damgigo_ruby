class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false
      t.string :title
      t.string :desc
      t.text :content
      t.attachment :image
      t.timestamps null: false
    end
  end
end
