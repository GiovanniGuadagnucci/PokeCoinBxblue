class TransactionsController < ApplicationController
  def buy_pokemon
    pokemon = transaction_params[:pokemon].to_i
    amount = transaction_params[:amount].to_i
    value = transaction_params[:value].to_f
    wallet = current_user.wallet
    check_transaction = TransactionServices::CheckBuyTransaction.call(value, wallet)

    return redirect_to root_url, notice: "You don't have enough funds to buy this pokemon" unless check_transaction

    TransactionServices::BuyTransactionResolution.call(pokemon, amount, value, wallet)
    redirect_to root_url, notice: 'Transaction successful'
  end

  def sell_pokemon
    pokemon = transaction_params[:pokemon].to_i
    amount = transaction_params[:amount].to_i
    value = transaction_params[:value].to_f
    wallet = current_user.wallet
    check_transaction = TransactionServices::CheckSellTransaction.call(pokemon, amount, wallet)

    return redirect_to root_url, notice: "You don't have enough pokemon to sell" unless check_transaction

    TransactionServices::SellTransactionResolution.call(pokemon, amount, value, wallet)
    redirect_to root_url, notice: 'Transaction successful'
  end

  private

  def transaction_params
    params.require(:transaction).permit(:pokemon, :amount, :value)
  end
end
