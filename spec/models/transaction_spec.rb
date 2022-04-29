require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
    @wallet = @user.wallet
    @transaction_buy = FactoryBot.create(:transaction, :buy, wallet: @wallet)
  end

  it 'should contain a encrypted id' do
    expect(@transaction_buy.attributes).to include('id')
    expect(@transaction_buy.id).to be_a(Integer)
  end

  it 'should contain a attritbute operation' do
    expect(@transaction_buy.attributes).to include('operation')
    expect(@transaction_buy.operation).to be_a(String)
  end

  it 'should contain a value' do
    expect(@transaction_buy.attributes).to include('value')
    expect(@transaction_buy.value).to be_a(BigDecimal)
  end

  it 'should contain a amount' do
    expect(@transaction_buy.attributes).to include('amount')
    expect(@transaction_buy.amount).to be_a(Integer)
  end

  it 'should contain a pokemon' do
    expect(@transaction_buy.attributes).to include('pokemon')
    expect(@transaction_buy.pokemon).to be_a(Pokemon)
  end

  it 'should contain a wallet' do
    expect(@transaction_buy.attributes).to include('wallet_id')
    expect(@transaction_buy.wallet).to be_a(Wallet)
  end

  it 'should be valid with valid attributes' do
    expect(@transaction_buy).to be_valid
  end

  it 'should not be valid without a operation' do
    transaction_buy2 = FactoryBot.build(:transaction, :buy, operation: nil)
    expect(transaction_buy2).to_not be_valid
  end

  it 'should not be valid without a value' do
    transaction_buy2 = FactoryBot.build(:transaction, :buy, value: nil)
    expect(transaction_buy2).to_not be_valid
  end

  it 'should not be valid without a amount' do
    transaction_buy2 = FactoryBot.build(:transaction, :buy, amount: nil)
    expect(transaction_buy2).to_not be_valid
  end

  it 'should not be valid without a pokemon' do
    transaction_buy2 = FactoryBot.build(:transaction, :buy, pokemon: nil)
    expect(transaction_buy2).to_not be_valid
  end

  it 'should not be valid without a wallet' do
    transaction_buy2 = FactoryBot.build(:transaction, :buy, wallet: nil)
    expect(transaction_buy2).to_not be_valid
  end
end
