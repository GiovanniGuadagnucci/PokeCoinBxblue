module TransactionServices
  class SellTransactionResolution < BxblueService
    def initialize(pokemon, amount, value, current_user)
      @pokemon = Pokemon.find(pokemon)
      @amount = amount
      @value = value
      @current_user = current_user
    end

    def call
      new_transaction
      receive_payment
      remove_pokemon_from_wallet
    end

    private

    def new_transaction
      transaction = Transaction.new(operation: 'sell', value: @value, amount: @amount,
                                    wallet_id: @current_user.wallet.id, pokemon: @pokemon)
      transaction.save
    end

    def receive_payment
      @current_user.wallet.balance += @value * @amount
      @current_user.wallet.save
    end

    def remove_pokemon_from_wallet
      @current_user.wallet.pokemons[@pokemon][:amount] -= @amount
      @current_user.wallet.pokemons.delete(@pokemon) if @current_user.wallet.pokemons[@pokemon][:amount] == 0
      @current_user.wallet.save
    end
  end
end
