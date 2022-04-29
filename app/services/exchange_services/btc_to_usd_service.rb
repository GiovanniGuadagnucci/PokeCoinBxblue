module ExchangeServices
  class BtcToUsdService < BxblueService
    def initialize(api = 'https://blockchain.info/ticker');
      @api = api
    end

    def call
      request
    end

    private

    def request
      response = HTTParty.get(@api)
      response['USD']['15m']
    end
  end
end
