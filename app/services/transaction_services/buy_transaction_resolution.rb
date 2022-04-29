module TransactionServices
  class BuyTransactionResolution < BxblueService
    def initialize(pokemon, amount, value, current_user)
      @pokemon = Pokemon.find(pokemon)
      @amount = amount
      @value = value
      @current_user = current_user
    end

    def call
      new_transaction
      payment
      check_if_pokemon_is_in_wallet
      add_pokemon_to_wallet
    end

    private

    def new_transaction
      transaction = Transaction.new(operation: 'buy', value: @value, amount: @amount,
                                    wallet_id: @current_user.wallet.id, pokemon: @pokemon)
      transaction.save
    end

    def payment
      @current_user.wallet.balance -= @value * @amount
      @current_user.wallet.save
    end

    def check_if_pokemon_is_in_wallet
      unless @current_user.wallet.pokemons.key?(@pokemon)
        @current_user.wallet.pokemons[@pokemon] = {
          amount: 0,
          total_paid_price: 0
        }
      end
    end

    def add_pokemon_to_wallet
      @current_user.wallet.pokemons[@pokemon][:amount] += @amount
      @current_user.wallet.pokemons[@pokemon][:total_paid_price] += @value
      @current_user.wallet.save
    end
  end
end
