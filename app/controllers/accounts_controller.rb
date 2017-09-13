class AccountsController < ApplicationController
  def index
  	@accounts = Account.all
  end

  def get_balance
  end

  def show_balance
  	@account = Account.find_by_id(params[:account][:id])
  	if @account.nil? 
  		flash[:alert] = 'Account does not exist'
  		render :get_balance
  	end
  end

  def show
  	@account = Account.find(params[:id])
  end
end
