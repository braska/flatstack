class ChangePostsTable < ActiveRecord::Migration
  def change
    change_column :posts, :title, :string, :null => false
  end
end
