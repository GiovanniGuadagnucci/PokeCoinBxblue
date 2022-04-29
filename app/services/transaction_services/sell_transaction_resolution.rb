module TransactionServices
  class SellTransactionResolution < BxblueService
    def initialize(pokemon, amount, value, wallet)
      @pokemon = Pokemon.find(pokemon)
      @amount = amount
      @value = value
      @wallet = wallet
    end

    def call
      new_transaction
      receive_payment
      remove_pokemon_from_wallet
    end

    private

    def new_transaction
      transaction = Transaction.new(operation: 'sell', value: @value, amount: @amount,
                                    wallet_id: @wallet.id, pokemon: @pokemon)
      transaction.save
    end

    def receive_payment
      @wallet.balance += @value * @amount
      @wallet.save
    end

    def remove_pokemon_from_wallet
      @wallet.pokemons[@pokemon][:amount] -= @amount
      @wallet.pokemons[@pokemon][:total_paid_price].pop
      @wallet.pokemons.delete(@pokemon) if @wallet.pokemons[@pokemon][:amount] == 0
      @wallet.save
    end
  end
end
