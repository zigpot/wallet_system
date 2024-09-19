class WalletsController < ApplicationController
    def show
      wallet = Wallet.find(params[:id]) # Find the wallet by its ID
  
      if wallet
        render json: { id: wallet.id, balance: wallet.balance }, status: :ok
      else
        render json: { error: 'Wallet not found' }, status: :not_found
      end
    end
  end