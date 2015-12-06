class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.text :content
      t.references :user, index: true, foreign_key: {on_delete: :cascade, on_update: :cascade}, :null => false
      t.references :post, index: true, foreign_key: {on_delete: :cascade, on_update: :cascade}, :null => false

      t.timestamps null: false
    end
  end
end
