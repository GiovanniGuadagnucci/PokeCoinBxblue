module ExchangeServices
  class UsdToBtcService < BxblueService
    def initialize(value)
      @value = value
    end

    def call
      request
    end

    def request
      HTTParty.get("https://blockchain.info/tobtc?currency=USD&value=#{@value}")
    end
  end
end
