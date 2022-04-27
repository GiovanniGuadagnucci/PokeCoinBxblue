module ExchangeServices
  class BtcToUsdService < BxblueService
    def initialize(value)
      @value = value
    end

    def call
      request
    end

    def request
      response = HTTParty.get('https://blockchain.info/ticker')
      puts response.parsed_response['USD']['15m']
    end
  end
end
