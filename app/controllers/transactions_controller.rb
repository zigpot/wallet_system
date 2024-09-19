class TransactionsController < ApplicationController
    def create
      ActiveRecord::Base.transaction do
        @transaction = Transaction.new(transaction_params)
  
        if @transaction.save
          @transaction.process!
          render json: { message: "Transaction completed successfully" }, status: :created
        else
          render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  
    private
  
    def transaction_params
      params.require(:transaction).permit(:source_wallet_id, :target_wallet_id, :amount, :transaction_type)
    end
  end