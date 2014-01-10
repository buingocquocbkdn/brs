class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @review = Review.new review_params
    @review.user_id = current_user.id
    @review.book_id = params[:book_id]
    if @review.save!
      flash[:success] = "Review created!"
    end
    redirect_to book_path params[:book_id]
  end
  
  def edit
    @review = Review.find params[:id]
    @book = Book.find params[:book_id]
  end
  
  def new
    @book = Book.find params[:book_id]
  end
  
  def show
    @review = Review.find params[:id]
  end
  
  def update
    @review = Review.find params[:id]
    @book = Book.find params[:book_id]
    if @review.update_attributes review_params
      flash[:success] = "Review updated"
    end
      redirect_to book_path params[:book_id]
  
  end

  def destroy
    @review.destroy
    redirect_to book_path params[:book_id]
  end
  
  private

    def review_params
      params.require(:review).permit(:content_review, :review_title)
    end
    
    def correct_user
      @review = current_user.reviews.find_by id: params[:id]
      redirect_to root_url if @review.nil?
    end
end