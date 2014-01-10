class BooksController < ApplicationController
  def index
    @books = Book.paginate page: params[:page], per_page: 8
  end

  def show
    @book = Book.find params[:id]
    @reviews = @book.reviews.paginate page: params[:page], per_page: 8
    @rate = current_user.rates.rate_number(@book.id).first unless current_user.nil?
    @buy = current_user.buys.bought(@book.id).first unless current_user.nil?
  end

end