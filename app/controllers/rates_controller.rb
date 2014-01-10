class RatesController < ApplicationController
  before_action :signed_in_user

  def create
    @rate = Rate.create! book_id: params[:book_id], user_id: current_user.id, rate: params[:rate][:rate]
    @book = Book.find params[:book_id]
    @book.update_attributes rating: @book.rates.average('rate')
    redirect_to @book
  end

  def destroy
    rate = Rate.find params[:id]
    rate.destroy!
    @book = Book.find params[:book_id]
    @book.update_attributes rating: @book.rates.average('rate')
    redirect_to @book
  end

  def update
    @rate = Rate.find params[:id]
    @rate.update_attributes book_id: params[:book_id], user_id: current_user.id, rate: params[:rate][:rate]
    @book = Book.find params[:book_id]
    @book.update_attributes rating: @book.rates.average('rate')
    redirect_to @book
  end


end
