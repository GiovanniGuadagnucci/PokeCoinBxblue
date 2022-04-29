class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :current_bitcoin_value

  def index
    @pokemons = Pokemon.all
    @wallet = current_user.wallet
    @transactions = current_user.wallet.transactions.reverse
    @user_pokemons = current_user.wallet[:pokemons]
  end

  private

  def current_bitcoin_value
    @bitcoin_value = ExchangeServices::BtcToUsdService.call
  end
end
