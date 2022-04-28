module TransactionServices
  class CheckBuyTransaction < BxblueService
    def initialize(value, wallet)
      @value = value
      @wallet = wallet
    end

    def call
      can_buy?
    end

    private

    def can_buy?
      return true if @value < @wallet.balance

      false
    end
  end
end
