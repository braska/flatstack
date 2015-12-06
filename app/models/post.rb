class Post < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  validates :title, presence: true
  has_many :comments, class_name: "PostComment"
end
