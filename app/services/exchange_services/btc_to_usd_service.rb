module ExchangeServices
  class BtcToUsdService < BxblueService
    def initialize; end

    def call
      request
    end

    private

    def request
      response = HTTParty.get('https://blockchain.info/ticker')
      response['USD']['15m']
    end
  end
end
