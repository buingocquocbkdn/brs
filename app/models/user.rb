class User < ActiveRecord::Base
  has_many :book
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :relationships, source: :following
  has_many :reverse_relationships, foreign_key: "following_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :readings
  has_many :reads
  has_many :favourites
  has_many :rates
  has_many :buys
  has_many :activities
  has_many :likes
  has_many :reviews
  has_many :comments
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  attr_accessor :not_validates_password
  validates :password, length: { minimum: 6 }, unless: :not_validates_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(other_user)
    relationships.find_by(following_id: other_user.id)
  end

  def reading?(book, user)
    readings.find_by book_id: book.id, user_id: user.id
  end

  def read?(book, user)
    reads.find_by book_id: book.id, user_id: user.id
  end

  def favourite?(book, user)
    favourites.find_by book_id: book.id, user_id: user.id
  end

  def follow!(other_user)
    relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(following_id: other_user.id).destroy!
  end

  def activiting?
    seft.activities.any? || seft.readings.any? ||
    seft.likes.any? || seft.rates.any?
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
