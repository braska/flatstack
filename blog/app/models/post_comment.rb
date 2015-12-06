class PostComment < ActiveRecord::Base
  default_scope { order('created_at ASC') }
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end
