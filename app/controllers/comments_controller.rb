class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def index
    
  end
  
  def create
    @comment = Comment.create comment_params
    @comment.user_id = current_user.id
    @comment.review_id = params[:review_id]
    if @comment.save
      flash[:success] = "Comment created"
    end
      redirect_to book_path params[:book_id]
  end
  
  def new
    @comment = Comment.find params [:id]
  end
  
  def show
    @comment = Comment.find params[:id]
  end
  
  def destroy
    @comment.destroy
    redirect_to book_path params[:book_id]
  end
  
end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def correct_user
      @comment = current_user.comments.find_by id: params[:id]
      redirect_to root_url if @comment.nil?
    end