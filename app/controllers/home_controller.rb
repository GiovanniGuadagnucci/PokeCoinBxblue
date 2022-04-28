class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :current_bitcoin_value

  def index
    @pokemons = Pokemon.all
    @current_user = current_user
    @transactions = current_user.wallet.transactions
    @wallet = current_user.wallet
    @transactions = current_user.wallet.transactions
  end

  private

  def current_bitcoin_value
    @bitcoin_value = ExchangeServices::BtcToUsdService.call
  end
end
