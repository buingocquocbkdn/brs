class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments
  default_scope -> { order('created_at DESC') }
  validates :content_review, presence: true, length: { maximum: 140 }
  validates :review_title, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validates :book_id, presence: true
end