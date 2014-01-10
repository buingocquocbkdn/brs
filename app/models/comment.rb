class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
end
