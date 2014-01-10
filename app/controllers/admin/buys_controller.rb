class Admin::BuysController < ApplicationController
   before_action :signed_in_admin

   def index
   		@buys = Buy.paginate page: params[:page], per_page: 3
   end

   def update
   	  @buy = Buy.find params[:id]
      case params[:request]
      when 'accept'
           @buy.update_attributes! buy_status: 1, 
                                   approve_buy_date: DateTime.now   
      when 'cancel'
           @buy.update_attributes! buy_status: 0, 
                                   approve_buy_date: nil
			end
			respond_to do |format|
	      format.html { redirect_to admin_buys_path }
	      format.js
			end
   end

   def destroy
      @buy = Buy.find params[:id]
		unless !@buy.nil? && @buy.bought?
		  @buy.destroy
      flash[:success] = "Request deleted."
      redirect_to admin_buys_path
    else
    	flash[:error] = "Request to accept. You can't remove."
      redirect_to admin_buys_path
    end
   end
end