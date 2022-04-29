module TransactionServices
  class BuyTransactionResolution < BxblueService
    def initialize(pokemon, amount, value, wallet)
      @pokemon = Pokemon.find(pokemon)
      @amount = amount
      @value = value
      @wallet  = wallet
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
                                    wallet_id: @wallet.id, pokemon: @pokemon)
      transaction.save
    end

    def payment
      @wallet.balance -= @value * @amount
      @wallet.save
    end

    def check_if_pokemon_is_in_wallet
      unless @wallet.pokemons.key?(@pokemon)
        @wallet.pokemons[@pokemon] = {
          amount: 0,
          total_paid_price: [],
        }
      end
    end

    def add_pokemon_to_wallet
      @wallet.pokemons[@pokemon][:amount] += @amount
      @wallet.pokemons[@pokemon][:total_paid_price] << @value
      @wallet.save
    end
  end
end
