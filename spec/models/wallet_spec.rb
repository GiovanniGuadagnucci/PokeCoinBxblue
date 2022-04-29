require 'rails_helper'

RSpec.describe Wallet, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
    @wallet = @user.wallet
  end

  it 'should contain a encrypted id' do
    expect(@wallet.attributes).to include('id')
    expect(@wallet.id).to be_a(Integer)
  end

  it 'should contain a attritbute balance' do
    expect(@wallet.attributes).to include('balance')
    expect(@wallet.balance).to be_a(BigDecimal)
  end

  it 'should contain a encrypted pokemons' do
    expect(@wallet.attributes).to include('pokemons')
    expect(@wallet.pokemons).to be_a(Hash)
  end

  it 'needs a user to be valid' do
    wallet2 = FactoryBot.build(:wallet, user: nil)
    expect(wallet2).to_not be_valid
  end

  it 'should start a balance of 1000' do
    expect(@wallet.balance).to eq(1000)
  end

  it 'should start with no pokemons' do
    expect(@wallet.pokemons).to eq({})
  end

  it 'should start with no transactions' do
    expect(@wallet.transactions).to eq([])
  end

  it 'should start with total investiment balance of 0' do
    bitcoin_value = 10_000
    expect(@wallet.invested_balance(bitcoin_value)).to eq(0)
  end

  it 'should start with total avaluation balance of 1000' do
    bitcoin_value = 10_000
    expect(@wallet.wallet_total_avaluation_balance(bitcoin_value)[:current_value]).to eq(1000)
  end

  it 'should start with total avaluation percentage of 0' do
    bitcoin_value = 10_000
    expect(@wallet.wallet_total_avaluation_balance(bitcoin_value)[:percentage]).to eq(0)
  end
end
