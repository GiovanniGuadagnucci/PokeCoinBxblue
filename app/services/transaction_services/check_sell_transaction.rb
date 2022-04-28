module TransactionServices
  class CheckSellTransaction < BxblueService
    def initialize(pokemon, amount, wallet)
      @pokemon = Pokemon.find(pokemon)
      @amount = amount
      @wallet = wallet
    end

    def call
      can_sell?
    end

    private

    def can_sell?
      return true if @wallet.pokemons.include?(@pokemon) && @wallet.pokemons[@pokemon] >= @amount

      false
    end
  end
end
