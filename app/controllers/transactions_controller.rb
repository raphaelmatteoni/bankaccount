class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new()
  end

  def create
    prepare_params
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to transaction_path(@transaction)
    else
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end


  private

  def collection
    @transactions ||= end_of_association_chain.order('created_at').page(params[:page]).per(40)
  end

  def transaction_params
    params.require(:transaction).permit(:source_account_id, :destination_account_id, :amount)
  end

  protected
  def prepare_params
    params[:transaction][:amount].gsub!('R$ ', ' ')
    params[:transaction][:amount].gsub!('.', '')
    params[:transaction][:amount].gsub!(',', '.')
  end
end
