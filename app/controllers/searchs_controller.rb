class SearchsController < ApplicationController
  def index
    @book = Book.new
  end

  def new
    case
    when params[:rating].present?
      @books = Book.search_book_by_rate(params[:title], params[:category_id],
      params[:rating]).paginate page: params[:page], per_page: 8
    when params[:favourite_num].present?
      @books = Book.search_book_by_favourite(params[:title], params[:category_id],
      params[:favourite_num]).paginate page: params[:page], per_page: 8
    when params[:rating].present? && params[:favourite_num].present?
      @books = Book.search_book_by_rate_favourite(params[:title], params[:category_id],
      params[:rating], params[:favourite_num]).paginate page: params[:page], per_page: 8
    else
      @books = Book.search_book_by_title_cat(params[:title], params[:category_id])
      .paginate page: params[:page], per_page: 8
    end
  end

end
