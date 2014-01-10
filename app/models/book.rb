class Book < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :reviews
	has_many :buys
	has_many :favourites
	has_many :reads
	has_many :readings
	has_many :rates

  scope :search_book_by_title_cat, lambda { |title, category_id| {conditions:
  "title LIKE \"%#{title}%\" AND category_id = #{category_id}"} }

  scope :search_book_by_rate, lambda { |title, category_id, rating| {conditions:
  "title LIKE \"%#{title}%\" AND category_id = #{category_id} AND rating >= #{rating}"} }

  scope :search_book_by_favourite, lambda { |title, category_id, favourite_num|
  joins(:favourites).where("title LIKE \"%#{title}%\" AND category_id = #{category_id}")
  .group("books.id").having("count(books.id) >= #{favourite_num}")}

  scope :search_book_by_rate_favourite, lambda { |title, category_id, rating, favourite_num|
  joins(:favourites).where("title LIKE \"%#{title}%\" AND category_id = #{category_id} AND rating >= #{rating}")
   .group("books.id").having("count(books.id) >= #{favourite_num}") }
end
