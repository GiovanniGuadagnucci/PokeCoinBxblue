require 'rails_helper'

RSpec.describe ExchangeServices::BtcToUsdService, type: :model do
  it 'should respond to #call' do
    expect(ExchangeServices::BtcToUsdService.new).to respond_to(:call)
  end

  it 'should contain only one public instance method named #call' do
    expect(ExchangeServices::BtcToUsdService.instance_methods(false)).to eq([:call])
  end

  it 'should return a value of type Float' do
    expect(ExchangeServices::BtcToUsdService.call).to be_a(Float)
  end
end
